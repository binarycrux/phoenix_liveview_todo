defmodule TaskifyWeb.TaskController do
  use TaskifyWeb, :controller

  alias Taskify.Task
  alias Taskify.Tasks

  plug :fetch_current_user

  defp fetch_current_user(conn, _opts) do
    user = conn.assigns.current_user
    assign(conn, :current_user, user)
  end

  # Action to create new todo to the database
  def create(conn, %{"task" => task_params}) do
    user_id = conn.assigns.current_user.id
    task_params = Map.put(task_params, "user_id", user_id)

    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/tasks")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "Changeset errors")
        |> put_flash(:info, "Error! Task was not created.")
        |> redirect(to: ~p"/tasks")
    end
  end

  # Action to toggle status of a task
  def toggle_status(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    new_status = if task.status == "pending", do: "done", else: "pending"

    case Tasks.update_status(task, %{status: new_status}) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task status updated successfully.")
        |> redirect(to: ~p"/tasks")
      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "Update errors")
        conn
        |> put_flash(:error, "Failed to update task status.")
        |> redirect(to: ~p"/tasks")
    end
  end

  # Action to handle displaying task edit template
  def edit(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    changeset = Task.changeset(task, %{})
    render(conn, :edit, task: task, changeset: changeset)
  end

  # Action to handle updating edited task
  def update_task(conn, %{"id" => id, "task" => new_task}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)

    case Tasks.update_task(task, new_task) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/tasks/")
      {:error, changeset} ->
        render(conn, :edit, task: task, changeset: changeset)
    end
  end

  # Action to handle task delete
  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/tasks")
  end
end
