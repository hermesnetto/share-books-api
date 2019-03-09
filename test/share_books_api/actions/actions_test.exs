defmodule ShareBooksApi.ActionsTest do
  use ShareBooksApi.DataCase

  alias ShareBooksApi.Actions

  describe "queues" do
    alias ShareBooksApi.Actions.Queue

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def queue_fixture(attrs \\ %{}) do
      {:ok, queue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_queue()

      queue
    end

    test "list_queues/0 returns all queues" do
      queue = queue_fixture()
      assert Actions.list_queues() == [queue]
    end

    test "get_queue!/1 returns the queue with given id" do
      queue = queue_fixture()
      assert Actions.get_queue!(queue.id) == queue
    end

    test "create_queue/1 with valid data creates a queue" do
      assert {:ok, %Queue{} = queue} = Actions.create_queue(@valid_attrs)
    end

    test "create_queue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_queue(@invalid_attrs)
    end

    test "update_queue/2 with valid data updates the queue" do
      queue = queue_fixture()
      assert {:ok, %Queue{} = queue} = Actions.update_queue(queue, @update_attrs)
    end

    test "update_queue/2 with invalid data returns error changeset" do
      queue = queue_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_queue(queue, @invalid_attrs)
      assert queue == Actions.get_queue!(queue.id)
    end

    test "delete_queue/1 deletes the queue" do
      queue = queue_fixture()
      assert {:ok, %Queue{}} = Actions.delete_queue(queue)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_queue!(queue.id) end
    end

    test "change_queue/1 returns a queue changeset" do
      queue = queue_fixture()
      assert %Ecto.Changeset{} = Actions.change_queue(queue)
    end
  end
end
