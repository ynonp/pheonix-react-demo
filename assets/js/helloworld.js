import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom';
import socket from "./socket"

function useChannel(onNewMessage) {
  let channel = socket.channel("room:lobby", {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on("new_msg", payload => {
    console.log(payload);
    onNewMessage(payload.body);
  })

  return channel;
}

function App(props) {
  const [messages, setMessages] = useState(props.messages);
  const channel = useChannel(function(newMessage) {
    setMessages(val => [...val, newMessage]);
  });

  function sendMessage(e) {
    e.preventDefault();
    const inputElement = e.target.querySelector('input[name="message-text"]');
    const messageText = inputElement.value;

    channel.push("new_msg", {body: messageText})
    inputElement.value = '';
  }

  return (
    <div>
      <h1>Hello React World</h1>
      <form onSubmit={sendMessage}>
        <label>
          Message:
          <input type="text" name="message-text" />
        </label>
        <input type="submit" value="Send" />
      </form>
      <h1>Messages</h1>
      <ul>
        {messages.map(msg => (
          <li key={msg.id}>{msg.text}</li>
        ))}
      </ul>
    </div>
  );
}

ReactDOM.render(<App {...window.Gon.assets()} />, document.querySelector('main'));
