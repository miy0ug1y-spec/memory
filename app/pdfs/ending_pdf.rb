require "prawn"
require "rqrcode"
require "stringio"

class EndingPdf
  def initialize(ending)
    @ending = ending
  end

  def render
    pdf = Prawn::Document.new(
      page_size: "A4",
      margin: 50
    )

    register_japanese_font(pdf)
    pdf.font "NotoSansJP"
    

    add_title(pdf)
    add_profile(pdf)
    add_ending_content(pdf)
    add_memory_posts(pdf)

    pdf.render
  end

  def register_japanese_font(pdf)
    font_path = Rails.root.join(
      "app",
      "assets",
      "fonts",
      "NotoSansJP-Regular.ttf"
    )

    unless File.exist?(font_path)
      raise "日本語フォントが見つかりません : #{font_path}"
    end

  pdf.font_families.update(
    "NotoSansJP" => {
      normal: font_path.to_s
    }
  )
  end

  def add_title(pdf)
    pdf.text "MyEnding", size: 26, align: :center
    pdf.move_down 10

    pdf.stroke_horizontal_rule
    pdf.move_down 25
  end

  def add_profile(pdf)
    pdf.text "◇プロフィール◇", size: 16
    pdf.move_down 12

    add_item(pdf, "氏名", full_name)
    add_item(pdf,"生年月日", birthday)
  end

  def add_ending_content(pdf)
    pdf.move_down 40
    pdf.text "<大切な人に伝えたいことや感謝の気持ち>", size: 16, align: :center

    pdf.move_down 20
    pdf.text @ending.feeling.presence || "未入力", size: 11

    if @ending.image.attached?
      pdf.move_down 15
      
      if @ending.image.image?
        add_ending_image(pdf)
      elsif @ending.image.video?
        add_video_qr(pdf, @ending.image)
      end

    end

    pdf.move_down 80
    pdf.text "<エピソード　ー忘れられない記憶や懐かしい思い出ー>", size: 16, align: :center

    pdf.move_down 20
    pdf.text @ending.episode.presence || "未入力", size: 11
  end

  def add_memory_posts(pdf)
    posts = @ending.posts.with_attached_image
    return if posts.empty?
    pdf.start_new_page 

    pdf.move_down 80

    pdf.text "<memoryのあしあと>", size: 16, align: :center
    pdf.move_down 20

    posts.each_with_index do |post|
      pdf.start_new_page if pdf.cursor < 300

      pdf.text(
        post.title.presence || "無題",
        size: 15
      )

      pdf.move_down 10
      add_post_image(pdf, post)

      pdf.move_down 15
      pdf.text(
        post.body.presence || "本文はありません", size: 11
      )

      pdf.move_down 12
      pdf.text(
        post.created_at.strftime("%Y年%m月%d日"),
        size: 9,
        align: :right
      )
    end
  end

  def add_video_qr(pdf, attachment)
    video_url = Rails.application.routes.url_helpers.rails_blob_url(
      attachment,
      host: "http://43.207.69.132"
    )

    qr = RQRCode::QRCode.new(video_url)

    png = qr.as_png(
      size: 300,
      border_modules:4
    )

    pdf.text "動画", size:14
    pdf.move_down 10

    pdf.image StringIO.new(png.to_s),
    width: 120,
    position: :center

    pdf.move_down 5

    pdf.text(
      "QRコードを読み取ると動画を再生できます",
      size: 9,
      align: :center
    )
  end

   

  def add_item(pdf, label, value)
    pdf.text label, size: 12
    pdf.move_down 5

    pdf.text value.presence || "未入力", size: 11
    pdf.move_down 18
  end

  def full_name
    name=[
      @ending.user.last_name,
      @ending.user.first_name
    ].compact.join(" ").presence || "未設定"
    "#{name} #{@ending.user.gender_japanese}"
  end

  def birthday
    @ending.user.birthday&.strftime("%Y年%m月%d日") || "未設定"
  end

  def add_post_image(pdf, post)
    return unless post.image.attached?

    converted_image = post.image.variant(
      resize_to_limit: [250, 180],
      format: :png
    ).processed

    converted_image.blob.open do |file|
      pdf.image(
        file.path,
        fit: [250, 180],
        position: :center
      )
    end

  rescue StandardError => e
    Rails.logger.error(
      "PDFへの画像追加に失敗しました :#{e.class} #{e.message}"
    )
  
    pdf.text "画像を表示できませんでした", size: 9
  end

  def add_ending_image(pdf)
    return unless @ending.image.attached?

    converted_image = @ending.image.variant(
      resize_to_limit: [250, 180],
      format: :png
    ).processed

    converted_image.blob.open do |file|
      pdf.image(
        file.path,
        fit: [250, 180],
        position: :center
      )
    end

    rescue StandardError => e
      Rails.logger.error(
        "画像のPDF追加に失敗しました: #{e.class} #{e.message}"
      )
    
    pdf.text "画像を表示できませんでした", size:9
  end


end
