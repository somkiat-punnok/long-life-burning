part of constant;

Future<void> checkAuth(UserProvider userProvider, FirebaseUser user) async {
  if (user != null) {
    await Configs.store
      .collection(Configs.collection_user)
      .where(
        Configs.uid_field,
        isEqualTo: user.uid,
      )
      .snapshots()
      .listen((data) {
        if (data.documents.isNotEmpty) {
          Configs.login = true;
          userProvider.setUser(
            userNew: user,
            idNew: data.documents[0].documentID,
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

num calculateCalories({
  DateTime age,
  Gender gender,
  num height,
  num weight,
  num seconds,
  num steps,
}) => (getMetForActivity(
      kilometersToMiles(
        calculateDistanceInKm(
          steps,
          calculateStepToMeters(height, gender)
        )
      ) / secondsToHours(seconds)
    ) * (3.5 / convertKilocaloriesToMlKmin(
      harrisBenedictRmr(
        gender,
        weight,
        getAgeFromDateOfBirth(age),
        centimeterToMeters(height)
      ),
      weight
    ))
  ) * secondsToHours(seconds) * weight;

num calculateCaloriesWithDistance({
  DateTime age,
  Gender gender,
  num height,
  num weight,
  num seconds,
  num distance,
}) => (getMetForActivity(
      kilometersToMiles(distance) / secondsToHours(seconds)
    ) * (3.5 / convertKilocaloriesToMlKmin(
      harrisBenedictRmr(
        gender,
        weight,
        getAgeFromDateOfBirth(age),
        centimeterToMeters(height)
      ),
      weight
    ))
  ) * secondsToHours(seconds) * weight;

num getAgeFromDateOfBirth(DateTime date) {
  DateTime currentDate = DateTime.now();
  if (date.compareTo(currentDate) > 0) throw ("Can't be born in the future");
  num currentYear = currentDate.year;
  num dateYear = date.year;
  num age = currentYear - dateYear;
  num currentMonth = currentDate.month;
  num dateMonth = date.month;
  if (dateMonth > currentMonth) {
    age--;
  } else if (currentMonth == dateMonth) {
    num currentDay = currentDate.day;
    num dateDay = date.day;
    if (dateDay > currentDay) {
      age--;
    }
  }
  return age;
}

num convertKilocaloriesToMlKmin(num kilocalories, num weightKgs) {
  return ((((kilocalories / 1440.0) / 5.0) / (weightKgs)) * 1000.0);
}

num calculateDistanceInKm(num steps, num entityStrideLength) {
  return ((steps * entityStrideLength) / 1000.0);
}

num getMetForActivity(num speedInMph) {
  if (speedInMph < 2.0) {
    return 2.0;
  } else if (speedInMph.compareTo(2.0) == 0) {
    return 2.8;
  } else if (speedInMph.compareTo(2.7) <= 0) {
    return 3.0;
  } else if (speedInMph.compareTo(3.3) <= 0) {
    return 3.5;
  } else if (speedInMph.compareTo(3.5) <= 0) {
    return 4.3;
  } else if (speedInMph.compareTo(4.0) <= 0) {
    return 5.0;
  } else if (speedInMph.compareTo(4.5) <= 0) {
    return 7.0;
  } else if (speedInMph.compareTo(5.0) <= 0) {
    return 8.3;
  } else if (speedInMph.compareTo(6.0) <= 0) {
    return 9.8;
  } else if (speedInMph.compareTo(7.0) <= 0) {
    return 11.0;
  } else if (speedInMph.compareTo(8.0) <= 0) {
    return 11.8;
  } else if (speedInMph.compareTo(9.0) <= 0) {
    return 12.8;
  } else if (speedInMph.compareTo(10.0) <= 0) {
    return 14.5;
  } else if (speedInMph.compareTo(11.0) <= 0) {
    return 16.0;
  } else if (speedInMph.compareTo(12.0) <= 0) {
    return 19.0;
  } else if (speedInMph.compareTo(13.0) <= 0) {
    return 19.8;
  } else if (speedInMph.compareTo(13.0) > 0) {
    return 23.0;
  }
  return 0;
}

num harrisBenedictRmr(Gender gender, num weight, num age, num height) {
  if (gender == Gender.FEMALE) {
    return 447.593 + (3.098 * height) + (9.247 * weight) - (4.330 * age);
    // return 655.0955 + (1.8496 * height) + (9.5634 * weight) - (4.6756 * age);
  } else {
    return 88.362 + (4.799 * height) + (13.397 * weight) - (5.677 * age);
    // return 66.4730 + (5.0033 * height) + (13.7516 * weight) - (6.7550 * age);
  }
}

num secondsToHours(num seconds) {
  return seconds / 60.0 / 60.0;
}

num kilometersToMiles(num kilometers) {
  return kilometers * 0.621371192;
}

num milesToKilometers(num miles) {
  return miles * 1.609344;
}

num centimeterToMeters(num cm) {
  return cm / 100.0;
}

num meterToCentimeters(num m) {
  return m * 100.0;
}

num calculateStepToMeters(num height, Gender gender) {
  return centimeterToMeters((gender == Gender.FEMALE ? 0.413 : 0.415) * height);
}
