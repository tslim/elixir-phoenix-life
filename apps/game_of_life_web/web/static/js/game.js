import socket from "./socket"

class Game {

  constructor() {
    this.channel = socket.channel("game:update", {})
    this.cols = $(".game-board").data("cols")
    this.rows = $(".game-board").data("rows")
  }

  init() {
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    $("[data-behavior=start-game]").on('click', () => {
      this.updateGameState("start")
      this.submitBoardState()
    })

    $("[data-behavior=reset-game]").on('click', () => {
      this.updateGameState("reset")
    })

    $("[data-cell-id]").on('click', (e) => {
      $(e.currentTarget).toggleClass("active")
    })
  }

  submitBoardState() {
    this.channel.push("game_state", { state: this.getBoardState(), cols: this.cols, rows: this.rows })
      .receive("ok", resp => {
        this.updateBoardState(resp.state)
      })
  }

  getBoardState() {
    var active_cells = $("[data-cell-id].active").map(function(){
      return $(this).data('cell-id').replace("-",",")
    }).get()
    return active_cells
  }

  resetBoardState() {
    $("[data-cell-id].active").removeClass("active")
  }

  updateBoardState(state) {
    this.resetBoardState()
    state.forEach(function (cell) {
      $(`[data-cell-id=${cell.join("-")}]`).addClass("active")
    })
  }

  updateGameState(state) {
    switch(state) {
      case "start":
        this.updateStartButton("Next")
        break;
      case "reset":
        this.updateStartButton("Start")
        this.resetBoardState()
        break;
    }

  }

  updateStartButton(text) {
    $("[data-behavior=start-game]").html(text)
  }

}

export default Game