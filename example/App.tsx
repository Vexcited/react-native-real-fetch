import { fetch } from "react-native-real-fetch"
import { useState } from 'react';

import {
  SafeAreaView,
  TextInput,
  Button,
} from 'react-native';

function App() {
  const [url, setUrl] = useState("http://localhost:6000");
  const [followRedirects, setFollowRedirects] = useState(true);

  const handleFetch = async () => {
    try {
      const response = await fetch(url, {
        method: "GET",
        redirect: followRedirects ? "follow" : "manual",
        headers: { hello: "world" }
      });

      console.log(response.status, response.statusText)
      console.log(response.redirected, response.url)
      console.log(response.headers);

      const body = await response.text();
      console.log({ body });
    }
    catch (error) {
      console.error(error);
    }
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
