class ProductParameters
  include StoreModel::Model

  def price
    throw NotImplementedError
  end
end
