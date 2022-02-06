defmodule Store.Client do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :city, :gender, :birthday, :phone, :discount]

  schema "clients" do
    field :name, :string, size: 64
    field :city, :string, size: 24
    field :gender, :string, size: 1
    field :birthday, :date
    field :phone, :string, size: 13
    field :discount, :integer
    has_many :order, Store.Order
    many_to_many :makers, Store.Maker, join_through: "orders"
    timestamps()
  end

  def changeset(%__MODULE__{} = client, attrs) do
    client
    |> cast(attrs, @fields)
    |> validate_required([:name, :phone, :city])
    |> validate_format(:phone, ~r/^[+]380/)
  end
end
