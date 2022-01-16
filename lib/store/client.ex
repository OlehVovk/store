defmodule Store.Client do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :city, :gender, :birhtday, :phone, :discount]

  schema "clients" do
    field :name, :string, size: 64
    field :city, :string, size: 24
    field :gender, :string, size: 1
    field :birthday, :date
    field :phone, :string, size: 10
    field :discount, :integer
    has_many :order, Store.Order
    timestamps()
  end

  def changeset(%__MODULE__{} = client, attrs) do
    client
    |> cast(attrs, @fields)
    |> validate_required([:name, :phone, :birthday])

    #  |> validate_format(client, :phone, +380) #добить проверку номера
  end
end

# связать клиентов и мейкеров через мєни ту мєни
