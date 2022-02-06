defmodule Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :maker_id, :price]

  schema "products" do
    belongs_to :maker, Store.Maker
    field :name, :string, size: 32
    field :price, :decimal
    timestamps()
  end

  def changeset(%__MODULE__{} = product, attrs) do
    product
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_number(:price, greater_than: 0)
  end
end
