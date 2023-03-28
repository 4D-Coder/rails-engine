class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name, :items
  has_many :items
  # def serializable_hash
  #   if super[:data].is_a?(Array)
  #     super
  #   else
  #     {data: [super[:data]]}
  #   end
  # end
  
end
