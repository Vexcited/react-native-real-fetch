import { fetch } from "react-native-real-fetch"
import { useState } from 'react';

import {
  SafeAreaView,
  TextInput,
  Button,
} from 'react-native';

function App() {
  const [url, setUrl] = useState("https://ec4f-46-193-4-24.ngrok-free.app");
  const [followRedirects, setFollowRedirects] = useState(true);

  const handleFetch = async () => {
    const response = await fetch(url, {
      redirect: followRedirects ? "follow" : "manual",
      headers: {
        hello: "world"
      }
    });

    console.log(response);
  };

  return (
    <SafeAreaView>
      <TextInput
        defaultValue={url}
        onChangeText={setUrl}
        placeholder="Input your URL !"
      />

      <Button
        title={"Redirection " + (followRedirects ? "ON" : "OFF")}
        onPress={() => setFollowRedirects(prev => !prev)}
      />

      <Button
        title="SEND"
        onPress={handleFetch}
      />
    </SafeAreaView>
  );
}

export default App;
