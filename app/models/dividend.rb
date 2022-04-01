class Dividend < ApplicationRecord
  belongs_to :countory
  #importメソッド
  def self.import(file)
    header = {
      id: "自動ID",
      countory_id: "国名番号",
      code: "銘柄コード",
      name: "銘柄名",
      income_date: "入金日",
      dividend_per_share: "1株配当（円）",
      shares: "保有株数",
      actual_dividend: "入金額（円）"
    }

    spreadsheet = open_spreadsheet(file)
    spreadsheet.each(header) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      divi= find_by(id: row[:id]) || new
      # CSVからデータを取得し、設定する
      divi.attributes = row
      divi.save
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv'  then Roo::CSV.new(file.path)
    when '.xls'  then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    when '.ods'  then Roo::OpenOffice.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
