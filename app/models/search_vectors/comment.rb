class SearchVectors::Comment < ActiveRecord::Base
  belongs_to :comment
  self.table_name = :comment_search_vectors
  ts_vector :search_vector
end
