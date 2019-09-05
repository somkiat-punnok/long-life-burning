import 'package:long_life_burning/utils/helper/constants.dart' show Gender;

double calculateEnergyExpenditure(
  double height,
  DateTime age,
  double weight,
  Gender gender,
  int durationInSeconds,
  int stepsTaken,
) => ( getMetForActivity(
      kilometersToMiles(
        calculateDistanceTravelledInKM(
          stepsTaken,
          calculateStepToMeters(1, height, gender)
        )
      ) / secondsToHours(durationInSeconds)) * (3.5 / convertKilocaloriesToMlKmin(
      harrisBenedictRmr(
        gender,
        weight,
        getAgeFromDateOfBirth(age),
        height
      ),
      weight
    ))) * secondsToHours(durationInSeconds) * weight;

int getAgeFromDateOfBirth(DateTime dateOfBirth) {
  DateTime currentDate = DateTime.now();
  if (dateOfBirth.compareTo(currentDate) > 0) throw ("Can't be born in the future");
  int currentYear = currentDate.year;
  int dateOfBirthYear = dateOfBirth.year;
  int age = currentYear - dateOfBirthYear;
  int currentMonth = currentDate.month;
  int dateOfBirthMonth = dateOfBirth.month;
  if (dateOfBirthMonth > currentMonth) {
    age--;
  } else if (currentMonth == dateOfBirthMonth) {
    int currentDay = currentDate.day;
    int dateOfBirthDay = dateOfBirth.day;
    if (dateOfBirthDay > currentDay) {
      age--;
    }
  }
  return age;
}

double convertKilocaloriesToMlKmin(double kilocalories, double weightKgs) {
  return ((((kilocalories / 1440) / 5) / (weightKgs)) * 1000);
}

double calculateDistanceTravelledInKM(int stepsTaken, double entityStrideLength) {
  return ((stepsTaken * entityStrideLength) / 1000);
}

double getMetForActivity(double speedInMph) {
  if (speedInMph < 2.0) {
    return 2.0;
  } else if (speedInMph.compareTo(2.0) == 0) {
    return 2.8;
  } else if (speedInMph.compareTo(2.0) > 0 && speedInMph.compareTo(2.7) <= 0) {
    return 3.0;
  } else if (speedInMph.compareTo(2.8) > 0 && speedInMph.compareTo(3.3) <= 0) {
    return 3.5;
  } else if (speedInMph.compareTo(3.4) > 0 && speedInMph.compareTo(3.5) <= 0) {
    return 4.3;
  } else if (speedInMph.compareTo(3.5) > 0 && speedInMph.compareTo(4.0) <= 0) {
    return 5.0;
  } else if (speedInMph.compareTo(4.0) > 0 && speedInMph.compareTo(4.5) <= 0) {
    return 7.0;
  } else if (speedInMph.compareTo(4.5) > 0 && speedInMph.compareTo(5.0) <= 0) {
    return 8.3;
  } else if (speedInMph.compareTo(5.0) > 0) {
    return 9.8;
  }
  return 0;
}

double harrisBenedictRmr(Gender gender, double weightKg, int age, double heightCm) {
  if (gender == Gender.FEMALE) {
    return 655.0955 + (1.8496 * heightCm) + (9.5634 * weightKg) - (4.6756 * age);
  } else {
    return 66.4730 + (5.0033 * heightCm) + (13.7516 * weightKg) - (6.7550 * age);
  }
}

double secondsToHours(int seconds) {
  return seconds / 60 / 60;
}

double kilometersToMiles(double kilometers) {
  return kilometers * 0.62137;
}

double centimeterToMeters(double cm) {
  return cm / 100;
}

double meterToCentimer(double m) {
  return m * 100;
}

double calculateStepToMeters(int steps, double heightInMeters, Gender gender) {
  return steps * centimeterToMeters(gender == Gender.FEMALE ? 0.413 : 0.415 * meterToCentimer(heightInMeters));
}
