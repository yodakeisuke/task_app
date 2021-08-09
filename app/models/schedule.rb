class Schedule < ApplicationRecord
    
    validates :title, presence: true
    validates :title, length: { maximum: 30 }
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate  :validate_overdue_now
    validate  :validate_overdue_start_date
    validates :memo, length: { maximum: 200 }
    
    def set_circle
        if self.all_day_flg == 1
            return "○" 
        else
            return ""
        end
    end

    private
    def validate_overdue_now
        return if end_date.nil?
        errors.add(:end_date, "が現在日付の過去です") if end_date.strftime("%x") < DateTime.current.strftime("%x")
    end
    
    def validate_overdue_start_date
        return if start_date.nil?
        return if end_date.nil?
        errors.add(:end_date, "が開始日の過去です") if end_date < start_date
    end
    
end
