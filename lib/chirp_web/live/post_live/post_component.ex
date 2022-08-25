defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
        </div>
        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b>
          <br />
          <%= @post.body %>
        </div>
      </div>

      <div class="row">
        <div class="column">
          <a href="#" phx-click="like" phx-target={@myself}>
            Likes <%= @post.likes_count %>
          </a>
        </div>
        <div class="column">
          <a href="#" phx-click="repost" phx-target={@myself}>
            Reposts <%= @post.repost_count %>
          </a>
        </div>
        <div class="column">
          <span>
            <%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %>
            <i class="far fa-edit"></i>
          </span>
          <span>
            <%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "are you sure?"] %>
            <i class="far fa-trash-alt"></i>
          </span>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
