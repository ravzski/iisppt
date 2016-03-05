module CommonScopes
  extend ActiveSupport::Concern

  module ClassMethods

    #
    # returns the complete details of the file including the creators's name
    # note: creator must exists
    #
    def complete_details
      select("#{self.table_name}.*,
      CONCAT_WS(' ',users.first_name ,users.last_name) as creator_name,
      CONCAT_WS(' ',updator.first_name ,updator.last_name) as updator_name").
      joins("inner join users on users.id = #{self.table_name}.creator_id").
      joins("inner join users updator on updator.id = #{self.table_name}.updator_id")
    end

    #
    # includes log to the query
    # note: creator and updator may not exist
    #
    def include_log
      select("#{self.table_name}.*,
      CONCAT_WS(' ',creator.first_name ,creator.last_name) as creator_name,
      CONCAT_WS(' ',updator.first_name ,updator.last_name) as updator_name").
      joins("left join users creator on creator.id = #{self.table_name}.creator_id").
      joins("left join users updator on updator.id = #{self.table_name}.updator_id")
    end


    #
    # query with limit
    # simplier alternative for load more features
    #
    def by_limit page, limit
      limit(limit).offset(limit*(page-1))
    end

    #
    # common active only query filter
    #
    def active
      where(is_active: true)
    end


    #
    # Common denomination if a query will be skipped or not
    #
    def is_skipped? value
      if !value.present? || value == 0 || value == "0"
        true
      else
        false
      end
    end

  end

  #
  # common scopes
  # only put scopes with conditional
  # so that it will be chainable
  #
  included do
    scope :where_timestamp_is, -> ts { where("exams.updated_at > ?", ts) if ts !="-1"}
    scope :not_self, -> id { where("id != ?", id) if id.present? }
    scope :where_like, ->(column,value){ where("#{column} LIKE LOWER(?)",  "#{value}%") if value.present? }
    scope :by_status, -> status { where(status: status) if status.present? }
  end


end
