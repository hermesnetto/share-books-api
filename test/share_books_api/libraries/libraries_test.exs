defmodule ShareBooksApi.LibrariesTest do
  use ShareBooksApi.DataCase

  alias ShareBooksApi.Libraries

  describe "categories" do
    alias ShareBooksApi.Libraries.Category

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Libraries.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Libraries.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Libraries.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Libraries.create_category(@valid_attrs)
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Libraries.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Libraries.update_category(category, @update_attrs)
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Libraries.update_category(category, @invalid_attrs)
      assert category == Libraries.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Libraries.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Libraries.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Libraries.change_category(category)
    end
  end

  describe "books" do
    alias ShareBooksApi.Libraries.Book

    @valid_attrs %{
      author: "some author",
      description: "some description",
      image: "some image",
      is_rent: true,
      publication_year: ~D[2010-04-17],
      publisher: "some publisher",
      title: "some title"
    }
    @update_attrs %{
      author: "some updated author",
      description: "some updated description",
      image: "some updated image",
      is_rent: false,
      publication_year: ~D[2011-05-18],
      publisher: "some updated publisher",
      title: "some updated title"
    }
    @invalid_attrs %{
      author: nil,
      description: nil,
      image: nil,
      is_rent: nil,
      publication_year: nil,
      publisher: nil,
      title: nil
    }

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Libraries.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Libraries.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Libraries.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Libraries.create_book(@valid_attrs)
      assert book.author == "some author"
      assert book.description == "some description"
      assert book.image == "some image"
      assert book.is_rent == true
      assert book.publication_year == ~D[2010-04-17]
      assert book.publisher == "some publisher"
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Libraries.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, %Book{} = book} = Libraries.update_book(book, @update_attrs)
      assert book.author == "some updated author"
      assert book.description == "some updated description"
      assert book.image == "some updated image"
      assert book.is_rent == false
      assert book.publication_year == ~D[2011-05-18]
      assert book.publisher == "some updated publisher"
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Libraries.update_book(book, @invalid_attrs)
      assert book == Libraries.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Libraries.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Libraries.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Libraries.change_book(book)
    end
  end

  describe "rents" do
    alias ShareBooksApi.Libraries.Rent

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def rent_fixture(attrs \\ %{}) do
      {:ok, rent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Libraries.create_rent()

      rent
    end

    test "list_rents/0 returns all rents" do
      rent = rent_fixture()
      assert Libraries.list_rents() == [rent]
    end

    test "get_rent!/1 returns the rent with given id" do
      rent = rent_fixture()
      assert Libraries.get_rent!(rent.id) == rent
    end

    test "create_rent/1 with valid data creates a rent" do
      assert {:ok, %Rent{} = rent} = Libraries.create_rent(@valid_attrs)
    end

    test "create_rent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Libraries.create_rent(@invalid_attrs)
    end

    test "update_rent/2 with valid data updates the rent" do
      rent = rent_fixture()
      assert {:ok, %Rent{} = rent} = Libraries.update_rent(rent, @update_attrs)
    end

    test "update_rent/2 with invalid data returns error changeset" do
      rent = rent_fixture()
      assert {:error, %Ecto.Changeset{}} = Libraries.update_rent(rent, @invalid_attrs)
      assert rent == Libraries.get_rent!(rent.id)
    end

    test "delete_rent/1 deletes the rent" do
      rent = rent_fixture()
      assert {:ok, %Rent{}} = Libraries.delete_rent(rent)
      assert_raise Ecto.NoResultsError, fn -> Libraries.get_rent!(rent.id) end
    end

    test "change_rent/1 returns a rent changeset" do
      rent = rent_fixture()
      assert %Ecto.Changeset{} = Libraries.change_rent(rent)
    end
  end
end
