#  inline_dialogs

A lightweight Flutter package to implement inline dialogs which can be managed from the main context.
The dialog can be closed from the same code from which it was invoked. 
It also gives back return values on closure helping the developer catch user action on the dialog.

## Getting Started

1. Add below builder code in MaterialApp() in main.dart page [sample](https://github.com/1SouravGhosh/flutter_inline_dialogs/blob/master/example/sample_app.dart/)

<pre>
<code class='language-dart hljs'>
 builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),

</code>
</pre>

2. Add dialogSetupLocator in main() in main.dart page [sample](https://github.com/1SouravGhosh/flutter_inline_dialogs/blob/master/example/sample_app.dart/)

<pre>
<code class='language-dart hljs'>
 void main() {
  dialogSetupLocator();
  runApp(MyApp());
}

</code>
</pre>

That's it! You are good to go. 

## Demo
<p><img src='https://raw.githubusercontent.com/1SouravGhosh/flutter_inline_dialogs/master/assets/explainer.gif' style='width: 30vw; min-width: 30px;' alt='Inline dialog demo'/>
</p>

# Implementation


1. Implement option dialog  [ dialogType: DialogType.option ]
<pre>
<code class='language-dart hljs'>
 var _dialogResponse = await _dialogService.showDialog(
                      title: Icon(
                        Icons.code,
                        size: 50,
                        color: Colors.orange,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Sample option dialog',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      dialogType: DialogType.option,
                      optionRight: 'Right',
                      optionLeft: 'Left');
                 
                    
print(_dialogResponse.optionRight);
print(_dialogResponse.optionLeft);
                  
</code>
</pre>

2. Implement confirm dialog  [ dialogType: DialogType.confirm ]
<pre>
<code class='language-dart hljs'>
 var _dialogResponse = await _dialogService.showDialog(
                      title: Icon(
                        Icons.done_outline,
                        size: 50,
                        color: Colors.green,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Sample confirm dialog',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      dialogType: DialogType.confirm,
                      buttonText: 'Done');
                 
                    setState(() {
                      _confirmBtn =  _dialogResponse.confirmed;
                  });
                                  
print('${_dialogResponse.confirmed}');
                  
</code>
</pre>

3. Implement waiter dialog  [ dialogType: DialogType.waiter]
<pre>
<code class='language-dart hljs'>
 _dialogService.showDialog(
                      title: Text(
                        'Sample waiter dialog',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CupertinoActivityIndicator(
                          radius: 20,
                        ),
                      ),
                      dialogType: DialogType.waiter);
                  await Future.delayed(Duration(seconds: 5));
                  _dialogService.dismissDialog();               
</code>
</pre>



You can close all of the above dialogs by using   _dialogService.dismissDialog(); from the same context where the dialog was invoked.

## Credit

A special shout out to FilledStacks YouTube channel. Please show some love and subscribe to this channel.
[YouTube Link](https://www.youtube.com/watch?v=IrFU_BrCWnE)

**The code has been modified heavily for ease of modular implementation and more features have been added.

## Documentation
For help getting started with Flutter, view our 
[github repo](https://github.com/1SouravGhosh/flutter_inline_dialogs/), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.



