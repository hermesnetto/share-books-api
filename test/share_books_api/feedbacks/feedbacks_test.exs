defmodule ShareBooksApi.FeedbacksTest do
  use ShareBooksApi.DataCase

  alias ShareBooksApi.Feedbacks

  describe "comments" do
    alias ShareBooksApi.Feedbacks.Comment

    @valid_attrs %{message: "some message", title: "some title"}
    @update_attrs %{message: "some updated message", title: "some updated title"}
    @invalid_attrs %{message: nil, title: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feedbacks.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Feedbacks.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Feedbacks.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Feedbacks.create_comment(@valid_attrs)
      assert comment.message == "some message"
      assert comment.title == "some title"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feedbacks.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Feedbacks.update_comment(comment, @update_attrs)
      assert comment.message == "some updated message"
      assert comment.title == "some updated title"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Feedbacks.update_comment(comment, @invalid_attrs)
      assert comment == Feedbacks.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Feedbacks.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Feedbacks.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Feedbacks.change_comment(comment)
    end
  end
end
