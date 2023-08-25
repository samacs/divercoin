class CryptoCurrencySerializer < Oj::Serializer
  hash_attributes :id, :name, :slug, :symbol, :metrics
end
