part of constant;

Future<void> checkAuth(UserProvider userProvider, FirebaseUser user) async {
  if (user != null) {
    await Configs.store
      .collection(Configs.collection_user)
      .where(
        Configs.uid_field,
        isEqualTo: user.uid,
      )
      .getDocuments()
      .then((data) {
        if (data.documents.isNotEmpty) {
          Configs.login = true;
          userProvider.setUser(
            userNew: user,
            nameNew: data.documents[0].data[Configs.name_field],
            weightNew: data.documents[0].data[Configs.weight_field],
            heightNew: data.documents[0].data[Configs.height_field],
            dateOfBirthNew: data.documents[0].data[Configs.dateOfBirth_field],
            genderNew: data.documents[0].data[Configs.gender_field],
          );
        }
      });
  }
}
