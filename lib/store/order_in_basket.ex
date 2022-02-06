defmodule Store.OrderInBasket do
  use Ecto.Schema
  import Ecto.Changeset
  @fields [:order_id, :product_id, :quantity, :discount]

  schema "order_basket" do
    belongs_to :order, Store.Order
    belongs_to :product, Store.Product
    field :quantity, :integer
    field :discount, :integer
    timestamps()
  end

  def changeset(%__MODULE__{} = order_in_basket, attrs) do
    order_in_basket
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_number(:quantity, greater_than: 0)
    |> validate_number(:discount, less_than: 50)
  end
end
