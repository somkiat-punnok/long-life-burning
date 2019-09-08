import 'package:long_life_burning/utils/helper/constants.dart' show Gender;

num calculateEnergyExpenditure(
  num height,
  DateTime age,
  num weight,
  Gender gender,
  num seconds,
  num steps,
) => ( getMetForActivity(
      kilometersToMiles(
        calculateDistanceTravelledInKM(
          steps,
          calculateStepToMeters(1, height, gender)
        )
      ) / secondsToHours(seconds)) * (3.5 / convertKilocaloriesToMlKmin(
        harrisBenedictRmr(
          gender,
          weight,
          getAgeFromDateOfBirth(age),
          height
        ),
        weight
      ))
    ) * secondsToHours(seconds) * weight;

num getAgeFromDateOfBirth(DateTime dateOfBirth) {
  DateTime currentDate = DateTime.now();
  if (dateOfBirth.compareTo(currentDate) > 0) throw ("Can't be born in the future");
  num currentYear = currentDate.year;
  num dateOfBirthYear = dateOfBirth.year;
  num age = currentYear - dateOfBirthYear;
  num currentMonth = currentDate.month;
  num dateOfBirthMonth = dateOfBirth.month;
  if (dateOfBirthMonth > currentMonth) {
    age--;
  } else if (currentMonth == dateOfBirthMonth) {
    num currentDay = currentDate.day;
    num dateOfBirthDay = dateOfBirth.day;
    if (dateOfBirthDay > currentDay) {
      age--;
    }
  }
  return age;
}

num convertKilocaloriesToMlKmin(num kilocalories, num weightKgs) {
  return ((((kilocalories / 1440) / 5) / (weightKgs)) * 1000);
}

num calculateDistanceTravelledInKM(num steps, num entityStrideLength) {
  return ((steps * entityStrideLength) / 1000);
}

num getMetForActivity(num speedInMph) {
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

num harrisBenedictRmr(Gender gender, num weightKg, num age, num heightCm) {
  if (gender == Gender.FEMALE) {
    return 655.0955 + (1.8496 * heightCm) + (9.5634 * weightKg) - (4.6756 * age);
  } else {
    return 66.4730 + (5.0033 * heightCm) + (13.7516 * weightKg) - (6.7550 * age);
  }
}

num secondsToHours(num seconds) {
  return seconds / 60 / 60;
}

num kilometersToMiles(num kilometers) {
  return kilometers * 0.62137;
}

num centimeterToMeters(num cm) {
  return cm / 100;
}

num meterToCentimer(num m) {
  return m * 100;
}

num calculateStepToMeters(num steps, num heightInMeters, Gender gender) {
  return steps * centimeterToMeters(gender == Gender.FEMALE ? 0.413 : 0.415 * meterToCentimer(heightInMeters));
}
