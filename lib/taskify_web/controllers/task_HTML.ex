defmodule TaskifyWeb.TaskHTML do
  @moduledoc """
  This module contains pages rendered by TaskController.

  See the `task_html` directory for all templates available.
  """
  use TaskifyWeb, :html

  embed_templates "task_html/*"
end
