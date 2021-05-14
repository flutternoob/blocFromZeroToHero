void main(List<String args>) {
  //Create a listenable stream to wait for items to arrive from the boatStream() function
  Stream<int> stream = boatStream();
  
  //Listen to the stream to carry out the print command once the data has been received from the boatStream() function
  stream.listen((receivedData) => print("Received boat number $receivedData"));
}

//This function generates the stream of data, in this case integers from 1 to 10
//A stream always uses "async*" instead of async as used in futures
//"*" indicates a generator function, i.e., a function which generates asynchronous data
//Instead of "return", "yield" keyword is used to send back data to the calling object,
//in this case the "stream" object in the main function

Stream<int> boatStream() async* {
  for (int i = 1; i <= 10; i++) {
    print("Sent boat number $i");
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
}
