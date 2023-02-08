### Welcome to the KZG Ceremony package

Follow this instructions to run a ceremony and make your contribution.

You can find two links bellow to choose how to make the contribution, with ethereum login or with github.

When you open it you will see something like this:

```
{"id_token":{"exp":18446744074709551615,"nickname":"0x70f263a331a9c3b3238537acf2470d933be741e3","provider":"Ethereum","sub":"eth|0x70f263a331a9c3b3238537acf2470d933be741e3"},"session_id":"a08cb52b-5156-4cf3-85c8-23157e45dec7"}
```

you will have to copy the code that appears in "session_id", in this example: a08cb52b-5156-4cf3-85c8-23157e45dec7

Then you will have to go to the [KZG config](http://my.dappnode/#/packages/kzg-ceremony.dnp.dappnode.eth/config) and paste the code in the "Session id" field, and click update.

after this you can check the logs of the package to see the progress of the ceremony

```
Waiting for our turn to contribute...
Still isn't our turn, waiting 30s for retrying...
Waiting for our turn to contribute...
Still isn't our turn, waiting 30s for retrying...
...
Contribution ready, took 2.91s
Sending contribution...
Success!
```

That's it! Two files will appear in your package and you'll be able to download them [file-manager](http://my.dappnode/#/packages/kzg-ceremony.dnp.dappnode.eth/file-manager):

`my_contribution.json` is exactly the contribution that was submitted to the sequencer.

`contribution_receipt.json` is the receipt returned by the sequencer for your contribution.

You can delete this package after the contribution is done.