require "prawn"

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
    add_memory_post(pdf)

    pdf.render
  end

  def register_japanese_font(pdf)
    font_path = Rails.root.join(
      "app",
      "assets",
      "fonts",
      "NotoSansJP-Regular.ttf"
    )

    unless Filse.exist?(font_path)
      raise "日本語フォントが見つかりません : #{font_path}"
    end

    pdf.font_families.update (
      "NotoSansJP" => {
        normal: font_path.to_s
      }
    )

    def add_title(pdf)
      pdf.text "MyEnding", size: 26, align: :center
      pdf.move_down 10

      pdf.stroke_horizontal_rule
      pdf.move_down 25
    end

    def add_profile(pdf)
      pdf.text "プロフィール", size: 16
      pdf.move_down 12

      add_item(pdf, "氏名", full_name)
      add_item(pdf,"生年月日", birthday)
    end

    def add_ending_content(pdf)
      pdf.move_down 10
      pdf.text "大切な人に伝えたいことや感謝の気持ち", size: 18, align: :center
      pdf.move_down 20

      pdf.text post.title.presence || "無題", size: 15
      pdf.move_down 10

      add_post_image(pdf, post)

      pdf.move_down 15
      pdf.text post.body.presence || "本文はありません", size: 11

      pdf.move_down 12
      pdf.text(
        post.created_at.strftime("%Y年%m月%d日"),
        size: 9,
        align: :right
      )
    end

    def add_post_image(pdf, post)
      return unless post.image.attached?

      converted_image = post.image.variant(
        resize_to_limit: [500, 350],
        format: :png
      ).processed

      converted_image.blob.open do |file|
        pdf.image(
          file.path,
          fit: [500, 350],
          position: :center
        )
      end
    rescue StandardError => e
      Rails.logger.error(
        "PDFへの画像追加に失敗しました： #{e.class} #{e.message}"
      )

      pdf.text "画像を表示できませんでした", size: 9
    end

    def add_item(pdf, label, value)
      pdf.text label, size: 12
      pdf.move_down 5

      pdf.text value.presence || "未入力", size: 11
      pdf.move_down 18
    end

    def full_name
      [
        @ending.user.last_name,
        @ending.user.first_name
      ].compact.join(" ").presence || "未設定"
    end

    def birthday
      @ending.user.birthday&.strftime("%Y年%m月%d日") || "未設定"
    end
end
