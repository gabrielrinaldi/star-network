import consumer from 'channels/consumer';

consumer.subscriptions.create('PresenceChannel', {
  // Called once when the subscription is created.
  initialized() {
    this.update = this.update.bind(this);
  },

  // Called when the subscription is ready for use on the server
  connected() {
    this.install();
    this.update();
  },

  // Called when the subscription has been terminated by the server
  disconnected() {
    this.uninstall();
  },

  // Called when the subscription is rejected by the server.
  rejected() {
    this.uninstall();
  },

  // Called when there's incoming data on the websocket for this channel
  received(data) {},

  update() {
    document.hidden ? this.away() : this.online();
  },

  // Calls `PresenceChannel#online` on the server.
  online() {
    this.perform('online');
  },

  // Calls `PresenceChannel#away` on the server.
  away() {
    this.perform('away');
  },

  install() {
    // window.addEventListener('focus', this.update);
    // window.addEventListener('blur', this.update);
    // document.addEventListener('turbo:load', this.update);
    document.addEventListener('visibilitychange', this.update);
  },

  uninstall() {
    // window.removeEventListener('focus', this.update);
    // window.removeEventListener('blur', this.update);
    // document.removeEventListener('turbo:load', this.update);
    document.removeEventListener('visibilitychange', this.update);
  },
});
