import RegisterPage from "./RegisterPage";

@Entry
@Component
 struct Index {
  build() {
    Column() {
      Text("Index");
      RegisterPage();
    }

  }
}