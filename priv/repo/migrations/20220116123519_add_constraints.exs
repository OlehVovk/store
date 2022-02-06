defmodule Store.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def up do
    # makers
    alter table("makers") do
      add :itn, :string, size: 10, null: false
      modify :name, :string, size: 64, null: false
    end

    create unique_index("makers", [:itn])
    # -------------------------------------------------------
    # clients
    alter table("clients") do
      modify :name, :string, size: 64, null: false
      modify :city, :string, size: 24, null: false
      modify :phone, :string, size: 13, null: false
    end

    # -------------------------------------------------------
    # orders

    alter table("orders") do
      add :order_number, :integer, null: false
      modify :orderdata, :date, null: false
      modify :shiptype, :string, size: 24, null: false
      modify :shipcity, :string, size: 24, null: false
      modify :shipcost, :decimal, null: false
    end

    create unique_index("orders", [:order_number])
    # -------------------------------------------------------
    # products

    alter table("products") do
      modify :name, :string, size: 32, null: false
      modify :price, :decimal, null: false
    end

    create unique_index("products", [:name, :price])
    # -------------------------------------------------------
    # order_basket
    alter table("order_basket") do
      modify :quantity, :integer, null: false
    end

    create unique_index("order_basket", [:order_id, :product_id])
    # -------------------------------------------------------
  end

  def down do
    # order_basket
    drop index("order_basket", [:order_id, :product_id])

    alter table("order_basket") do
      modify :quantity, :integer, null: true
    end

    # -------------------------------------------------------
    # products
    drop index("products", [:name, :price])

    alter table("products") do
      modify :name, :string, size: 32, null: true
      modify :price, :decimal, null: true
    end

    # -------------------------------------------------------
    # orders
    alter table("orders") do
      remove :order_number
      modify :orderdata, :date, null: true
      modify :shiptype, :string, size: 24, null: true
      modify :shipcity, :string, size: 24, null: true
      modify :shipcost, :decimal, null: true
    end

    # -------------------------------------------------------
    # clients
    alter table("clients") do
      modify :name, :string, size: 64, null: true
      modify :city, :string, size: 24, null: true
      modify :phone, :string, size: 16, null: true
    end

    # -------------------------------------------------------
    # makers
    alter table("makers") do
      remove :itn
      modify :name, :string, size: 64
    end

    # -------------------------------------------------------
  end
end
