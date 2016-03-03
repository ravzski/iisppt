module Searchable
  extend ActiveSupport::Concern


  #
  # Put all search logic here
  #

  # fields where the query must be like %%
  LIKE_FIELDS = %w(
    first_name
    last_name
    email
  )

  # fields where query must be column = value
  EQUAL_FIELDS = %w(
    is_active
    admin
    id
  )

  #
  # servers an abstract to all modules involving search
  # override if neccessary
  # note: use scope, so that if query is nil, it'll still be chainable
  #
  included do
    scope :search, -> query { where(extract_query(query).join(' and ')) if query.present? }
    scope :filter_in, -> field,arr { where("#{field} in (?)", arr) if arr.present?}
    # similar to filter in but can be used in joins
    scope :array_filter, -> field,arr { sanitize_sql_array(["#{field} in (?)", arr]) if arr.present? }
  end

  module ClassMethods
    private

    #
    # servers an abstract to all modules involving search
    # override if neccessary
    #
    def extract_query query
      query_string = []
      query.each do |key, value|
        next if (value.to_s.strip() == '' || value.to_s.strip() == 'All' || key == 'limit')
        query_string.push build_query(key,value)
      end
      query_string
    end

    #
    # returns a sanitize sql query
    # sanitize queries can be found inside the proctected methods
    #
    def build_query key, value
      case key.to_s
      when *LIKE_FIELDS
        build_like_query(key,value)
      when *EQUAL_FIELDS
        build_equals_query(key,value)
      when *ARRAY_FIELDS
        build_in_query(key,value)
      end
    end


    protected

    #
    # servers an abstract to all modules involving search
    # override if neccessary
    #
    def build_like_query key, value
      sanitize_sql_array(["LOWER(#{self.table_name}.#{key}) LIKE LOWER(?)", "%#{value}%"])
    end

    def build_equals_query key, value
      sanitize_sql_array(["#{self.table_name}.#{key} = ?", value])
    end

    def build_in_query key, value
      sanitize_sql_array(["#{self.table_name}.#{key} in (?)", value])
    end

    def build_date_where column, from, to
      date_query = []
      date_query.push sanitize_sql_array(["(  CAST(#{column} as DATE) <= ? &&  CAST(#{column} as DATE) >=?)", to, from])
    end

    def build_year_where column, from, to
      date_query = []
      date_query.push sanitize_sql_array(["(EXTRACT(YEAR FROM #{column}) <= ? && EXTRACT(YEAR FROM #{column}) >=?)", to, from])
    end


  end

end
