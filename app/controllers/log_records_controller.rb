class LogRecordsController < ApplicationController
  before_action :set_log_record, only: [:show, :edit, :update, :destroy]

  # GET /log_records
  # GET /log_records.json
  def index
    @log_records = LogRecord.all
  end

  # GET /log_records/1
  # GET /log_records/1.json
  def show
  end

  # GET /log_records/new
  def new
    @log_record = LogRecord.new
  end

  # GET /log_records/1/edit
  def edit
  end

  # POST /log_records
  # POST /log_records.json
  def create
    @log_record = LogRecord.new(log_record_params)

    respond_to do |format|
      if @log_record.save
        format.html { redirect_to @log_record, notice: 'Log record was successfully created.' }
        format.json { render :show, status: :created, location: @log_record }
      else
        format.html { render :new }
        format.json { render json: @log_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_records/1
  # PATCH/PUT /log_records/1.json
  def update
    respond_to do |format|
      if @log_record.update(log_record_params)
        format.html { redirect_to @log_record, notice: 'Log record was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_record }
      else
        format.html { render :edit }
        format.json { render json: @log_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_records/1
  # DELETE /log_records/1.json
  def destroy
    @log_record.destroy
    respond_to do |format|
      format.html { redirect_to log_records_url, notice: 'Log record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log_record
      @log_record = LogRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_record_params
      params.require(:log_record).permit(:postfix_id, :client, :client_ip, :message_id, :status)
    end
end
