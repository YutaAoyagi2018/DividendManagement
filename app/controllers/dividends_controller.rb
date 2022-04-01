class DividendsController < ApplicationController
  before_action :set_dividend, only: %i[ show edit update destroy ]

  # GET /dividends or /dividends.json
  def index
    @dividends = Dividend.order(:id).page(params[:page]).per(15)
  end

  # GET /dividends/1 or /dividends/1.json
  def show
  end

  # GET /dividends/new
  def new
    @dividend = Dividend.new
    @countories = Countory.all
  end

  # GET /dividends/1/edit
  def edit
    @countories = Countory.all
  end

  # POST /dividends or /dividends.json
  def create
    @dividend = Dividend.new(dividend_params)

    respond_to do |format|
      if @dividend.save
        format.html { redirect_to dividend_url(@dividend), notice: "Dividend was successfully created." }
        format.json { render :show, status: :created, location: @dividend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dividend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dividends/1 or /dividends/1.json
  def update
    respond_to do |format|
      if @dividend.update(dividend_params)
        format.html { redirect_to dividend_url(@dividend), notice: "Dividend was successfully updated." }
        format.json { render :show, status: :ok, location: @dividend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dividend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dividends/1 or /dividends/1.json
  def destroy
    @dividend.destroy

    respond_to do |format|
      format.html { redirect_to dividends_url, notice: "Dividend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pie_chart
    @pie_chart= Dividend.order('sum_actual_dividend desc').group(:code).sum(:actual_dividend)
    @pie_chart_array = @pie_chart.to_a
    @sum = Dividend.sum(:actual_dividend).to_s(:delimited)
  end

  def line_chart
    @sum = Dividend.sum(:actual_dividend).to_s(:delimited)
    # 日付ごとの入金額を取得する
    chart= Dividend.group(:income_date).sum(:actual_dividend)
    # 累積の入金額に変換する
    a = chart.to_a
    b = []
    b[0] = a[0][1]
    for i in 1..a.count-1 do
      d = a[i][1]
      e = b[i-1]
      b[i] = d+e
    end
    c = []
    c[0] = [a[0][0].strftime("%Y-%m-%d"),b[0]]
    for i in 1..a.count-1 do
      c.append([a[i][0].strftime("%Y-%m-%d"),b[i]])
    end
    @line_chart = c.to_h
  end

  def column_chart
    @sum = Dividend.sum(:actual_dividend).to_s(:delimited)
    chart= Dividend.group(:income_date).sum(:actual_dividend)
    @a = chart.to_a
    @b = []


    first = Dividend.minimum(:income_date).since(1.month).beginning_of_month.to_date # スタートの次の月
    last = Date.today # 最新の今日の日付
    each_month = (first..last).map(&:beginning_of_month).uniq # スタートの次の月から当月までの月の配列
    @c =[{name: "damy", data: [[Dividend.minimum(:income_date).strftime("%Y-%m"), 0]]}] # スタートの月
    
    each_month.each do |e|
      @c[0][:data].append([e.strftime("%Y-%m"),0])  # ダミーの日付設定
    end
    
    j = 0
    @b.append([@a[0][0].strftime("%Y-%m"),@a[0][1]])
    # 月別にする
    for i in 1..@a.count-1 do
      if @b[j][0] == @a[i][0].strftime("%Y-%m")
        @b[j][1] = @b[j][1] + @a[i][1]
      else
        @b.append([@a[i][0].strftime("%Y-%m"),@a[i][1]])
        j = j + 1
      end
    end


    Dividend.all.each do |d|
      check = false
      @c.each do |c|
        if c[:name] == d.code.to_s
          c[:data].append([d.income_date.strftime("%Y-%m"), d.actual_dividend])
          check = true
        end
      end
      if check == false
        @c.append({name: d.code.to_s, data: [[d.income_date.strftime("%Y-%m"), d.actual_dividend]]})
      end
    end

    @column_chart1 = @b
    @column_chart2 = @c
  end

  def import
    Dividend.import(params[:file])
    redirect_to dividends_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dividend
      @dividend = Dividend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dividend_params
      params.require(:dividend).permit(:countory_id, :code, :name, :income_date, :dividend_per_share, :shares, :actual_dividend)
    end
end
