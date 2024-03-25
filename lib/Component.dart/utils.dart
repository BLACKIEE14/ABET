import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

// import 'package:path/path.dart';

// import 'package:path/path.dart';

import 'colors.dart';
export './colors.dart';

// export './pasteHandler.dart';

bool validateGroup(String groupPair) {
  try {
    const List msgroups = ["MM", "MS", "SM", "SS"];

    const List allavailables = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "=",
      "P",
      "R",
      "A",
      " ",
      "B",
      "W",
      "J",
      "N",
      "K",
      "X",
      "S",
      "F",
      "M",
    ];

    List pair = splitGroup(groupPair);

    String group = pair[0];
    String money = pair[1];

    print("GROUP ${group}");
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(group.substring(0, group.length - 1).length % 2);

    if (groupPair.length == 1) {
      return false;
    }

    List spit = group.split("");
    for (String c in spit) {
      if (!allavailables.contains(c)) {
        return false;
      }
    }

    if (BigInt.parse(money) == 0) {
      return false;
    }

    if (BigInt.tryParse(group) != null && group.length == 2) {
      return true;
    }

    if (group.isNotEmpty && money.isNotEmpty) {
      if (group.contains("A") ||
          group.contains("W") ||
          group.contains("N") ||
          group.contains("X")) {
        if (group.length == 1) {
          return true;
        }
      }

      if (group.contains("B")) {
        if (group.length == 2 && BigInt.tryParse(group[0]) != null) {
          return true;
        }
      }

      if (group.contains("P") && !group.contains("=")) {
        if (group.length == 2 && BigInt.tryParse(group[0]) != null) {
          return true;
        }
      }

      if (group.contains("P") &&
          "P".allMatches(group).length == 1 &&
          group.contains("=") &&
          "=".allMatches(group).length == 1 &&
          int.tryParse(group.substring(0, group.indexOf("P"))) != null) {
        List prefix = group.substring(0, group.indexOf("P")).split('');
        if (prefix.length == prefix.toSet().length) {
          return true;
        }
      }

      if (group.contains("F")) {
        print("lee lrr");

        if ("F".allMatches(group).length > 1) {
          return false;
        }
        if (group.contains("=") &&
            "=".allMatches(group).length == 1 &&
            group.length > 2) {
          print("FFF ${group.substring(1, group.indexOf("="))}");
          if (group.contains("F=") && int.tryParse(group[0]) != null) {
            return true;
          } else if (group[0] == "F" &&
              int.tryParse(group.substring(1, group.indexOf("="))) != null) {
            return true;
          }
        } else if (group.length == 2) {
          if (BigInt.tryParse(group[0]) != null ||
              BigInt.tryParse(group[1]) != null) {
            return true;
          }
        } else if (group.contains("R") &&
            !group.contains("FR") &&
            "R".allMatches(group).length == 1 &&
            group.length >= 4) {
          return true;
        }
      }

      if (group.contains("R") && 'R'.allMatches(group).length == 1) {
        if (group.contains("=")) {
          // if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
          //     group.substring(0, group.indexOf("=")).length % 2 == 0 &&
          //     BigInt.tryParse(group.substring(
          //             group.indexOf("=") + 1, group.indexOf("R"))) !=
          //         null) {
          //   return true;
          // }
          print("zxcvbn ${"=".allMatches(group)}");
          if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
              group.substring(0, group.indexOf("=")).length % 2 == 0 &&
              "=".allMatches(group).length == 1) {
            String multiNums = group.substring(0, group.indexOf("="));
            RegExp exp = RegExp(r"\d{2}");
            Iterable<Match> matches = exp.allMatches(multiNums);
            List<String?> xResults = matches.map((m) => m.group(0)).toList();

            for (String? x in xResults) {
              if (x![0] == x[1]) {
                return false;
              }
            }
            return true;
          }
        } else if (group.length == 3) {
          if (BigInt.tryParse(group.substring(0, 2)) != null) {
            if (group.substring(0, 2)[0] != group.substring(0, 2)[1]) {
              return true;
            }
          }
        } else if (group.length > 3 &&
            BigInt.tryParse(group.substring(0, group.indexOf("R"))) != null) {
          if (group.substring(0, 2)[0] != group.substring(0, 2)[1]) {
            return true;
          }
        }
      }
      print(
          "K condition ${int.tryParse(group.replaceAll("K", "").replaceAll("=", ''))}");
      if (group.contains("K") &&
          int.tryParse(group.replaceAll("K", "").replaceAll("=", '')) == null) {
        return false;
      }

      if (group.contains("KK") &&
          "K".allMatches(group).length == 2 &&
          group.length > 3 &&
          int.tryParse(group[0]) != null &&
          !group.contains("=KK")) {
        if (group.contains("=") && group.indexOf("=") < group.indexOf("K")) {
          return false;
        }
        return true;
      } else if (group.contains("K")) {
        print("K lee lay");
        if (group.length > 2) {
          if (group[group.length - 1] == "K" &&
              "K".allMatches(group).length == 1 &&
              !group.contains("=K")) {
            if (group.contains("=") &&
                group.indexOf("=") < group.indexOf("K")) {
              return false;
            }
            if (BigInt.tryParse(group[group.length - 3]) != null &&
                !hasOverlappingIntegers(group)) {
              return true;
            }
          }
        }
      }

      if (group.length == 2 && msgroups.contains(group)) {
        return true;
      }

      if (group.contains("J") && group[group.length - 1] == "=") {
        final firstJ = group.substring(0, group.indexOf("J"));
        final secondJ =
            group.substring(group.indexOf("J") + 1, group.length - 1);
        // final overlap = firstJ.split('');
        // overlap.removeWhere((element) => !secondJ.split('').contains(element));
        bool isFirstJOverlap = firstJ.length != firstJ.split('').toSet().length;
        bool isSecondJOverlap =
            secondJ.length != secondJ.split('').toSet().length;

        if (
            // firstJ != secondJ
            // && overlap.isEmpty
            // &&
            !isFirstJOverlap && !isSecondJOverlap) {
          if (BigInt.tryParse(firstJ) != null &&
              BigInt.tryParse(secondJ) != null) {
            return true;
          }
        }
      }

      if (group[group.length - 1] == "=" &&
          BigInt.tryParse(group.substring(0, group.length - 1)) != null &&
          group.substring(0, group.length - 1).length % 2 == 0) {
        return true;
      }
    }

    return false;
  } catch (e) {
    return false;
  }
}

bool validateOnlyPattern(String group) {
  try {
    const List msgroups = ["MM", "MS", "SM", "SS"];

    const List allavailables = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "=",
      "P",
      "R",
      "A",
      " ",
      "B",
      "W",
      "J",
      "N",
      "K",
      "X",
      "S",
      "F",
      "M",
    ];

    // List pair = splitGroup(groupPair);

    // String group = pair[0];
    // String money = pair[1];

    print("GROUP ${group}");
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(group.substring(0, group.length - 1).length % 2);

    // if (groupPair.length == 1) {
    //   return false;
    // }

    List spit = group.split("");
    for (String c in spit) {
      if (!allavailables.contains(c)) {
        return false;
      }
    }

    // if (BigInt.parse(money) == 0) {
    //   return false;
    // }

    if (BigInt.tryParse(group) != null && group.length == 2) {
      return true;
    }

    if (group.isNotEmpty) {
      if (group.contains("A") ||
          group.contains("W") ||
          group.contains("N") ||
          group.contains("X")) {
        if (group.length == 1) {
          return true;
        }
      }

      if (group.contains("B")) {
        if (group.length == 2 && BigInt.tryParse(group[0]) != null) {
          return true;
        }
      }

      if (group.contains("P") && !group.contains("=")) {
        if (group.length == 2 && BigInt.tryParse(group[0]) != null) {
          return true;
        }
      }

      if (group.contains("P") &&
          "P".allMatches(group).length == 1 &&
          group.contains("=") &&
          "=".allMatches(group).length == 1 &&
          int.tryParse(group.substring(0, group.indexOf("P"))) != null) {
        List prefix = group.substring(0, group.indexOf("P")).split('');
        if (prefix.length == prefix.toSet().length) {
          return true;
        }
      }

      if (group.contains("F")) {
        print("lee lrr");

        if ("F".allMatches(group).length > 1) {
          return false;
        }
        if (group.contains("=") &&
            "=".allMatches(group).length == 1 &&
            group.length > 2) {
          print("FFF ${group.substring(1, group.indexOf("="))}");
          if (group.contains("F=") && int.tryParse(group[0]) != null) {
            return true;
          } else if (group[0] == "F" &&
              int.tryParse(group.substring(1, group.indexOf("="))) != null) {
            return true;
          }
        } else if (group.length == 2) {
          if (BigInt.tryParse(group[0]) != null ||
              BigInt.tryParse(group[1]) != null) {
            return true;
          }
        } else if (group.contains("R") &&
            !group.contains("FR") &&
            "R".allMatches(group).length == 1 &&
            group.length >= 4) {
          return true;
        }
      }

      if (group.contains("R") && 'R'.allMatches(group).length == 1) {
        if (group.contains("=")) {
          // if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
          //     group.substring(0, group.indexOf("=")).length % 2 == 0 &&
          //     BigInt.tryParse(group.substring(
          //             group.indexOf("=") + 1, group.indexOf("R"))) !=
          //         null) {
          //   return true;
          // }
          print("zxcvbn ${"=".allMatches(group)}");
          if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
              group.substring(0, group.indexOf("=")).length % 2 == 0 &&
              "=".allMatches(group).length == 1) {
            String multiNums = group.substring(0, group.indexOf("="));
            RegExp exp = RegExp(r"\d{2}");
            Iterable<Match> matches = exp.allMatches(multiNums);
            List<String?> xResults = matches.map((m) => m.group(0)).toList();

            for (String? x in xResults) {
              if (x![0] == x[1]) {
                return false;
              }
            }
            return true;
          }
        } else if (group.length == 3) {
          if (BigInt.tryParse(group.substring(0, 2)) != null) {
            if (group.substring(0, 2)[0] != group.substring(0, 2)[1]) {
              return true;
            }
          }
        } else if (group.length > 3 &&
            BigInt.tryParse(group.substring(0, group.indexOf("R"))) != null) {
          if (group.substring(0, 2)[0] != group.substring(0, 2)[1]) {
            return true;
          }
        }
      }
      print(
          "K condition ${int.tryParse(group.replaceAll("K", "").replaceAll("=", ''))}");
      if (group.contains("K") &&
          int.tryParse(group.replaceAll("K", "").replaceAll("=", '')) == null) {
        return false;
      }

      if (group.contains("KK") &&
          "K".allMatches(group).length == 2 &&
          group.length > 3 &&
          int.tryParse(group[0]) != null &&
          !group.contains("=KK")) {
        if (group.contains("=") && group.indexOf("=") < group.indexOf("K")) {
          return false;
        }
        return true;
      } else if (group.contains("K")) {
        print("K lee lay");
        if (group.length > 2) {
          if (group[group.length - 1] == "K" &&
              "K".allMatches(group).length == 1 &&
              !group.contains("=K")) {
            if (group.contains("=") &&
                group.indexOf("=") < group.indexOf("K")) {
              return false;
            }
            if (BigInt.tryParse(group[group.length - 3]) != null &&
                !hasOverlappingIntegers(group)) {
              return true;
            }
          }
        }
      }

      if (group.length == 2 && msgroups.contains(group)) {
        return true;
      }

      if (group.contains("J") && group[group.length - 1] == "=") {
        final firstJ = group.substring(0, group.indexOf("J"));
        final secondJ =
            group.substring(group.indexOf("J") + 1, group.length - 1);
        // final overlap = firstJ.split('');
        // overlap.removeWhere((element) => !secondJ.split('').contains(element));
        bool isFirstJOverlap = firstJ.length != firstJ.split('').toSet().length;
        bool isSecondJOverlap =
            secondJ.length != secondJ.split('').toSet().length;

        if (
            // firstJ != secondJ
            // && overlap.isEmpty
            // &&
            !isFirstJOverlap && !isSecondJOverlap) {
          if (BigInt.tryParse(firstJ) != null &&
              BigInt.tryParse(secondJ) != null) {
            return true;
          }
        }
      }

      if (group[group.length - 1] == "=" &&
          BigInt.tryParse(group.substring(0, group.length - 1)) != null &&
          group.substring(0, group.length - 1).length % 2 == 0) {
        return true;
      }
    }

    return false;
  } catch (e) {
    return false;
  }
}

bool validateGroup3D(String groupPair) {
  try {
    List pair = splitGroup3D(groupPair);

    const List allavailables = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "=",
      "F",
      "R",
      "A",
      " ",
    ];

    print("pair");
    print(pair);

    String group = pair[0];
    String money = pair[1];

    print(group);
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(BigInt.tryParse(group.substring(0, group.length - 1)));
    print(group.substring(0, group.length - 1).length % 2);

    if (groupPair.length < 3) {
      return false;
    }

    List spit = group.split("");
    for (String c in spit) {
      if (!allavailables.contains(c)) {
        return false;
      }
    }

    if (BigInt.parse(money) == 0) {
      return false;
    }

    if (BigInt.tryParse(group) != null && group.length == 3) {
      return true;
    }

    if (group == "A") {
      return true;
    }

    if (group.contains("F") &&
        group.length == 3 &&
        'F'.allMatches(group).length == 1) {
      return true;
    }
    if ('='.allMatches(group).length > 1) {
      return false;
    }
    if (group.contains("=") && !group.contains("R")) {
      if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
          group.substring(0, group.indexOf("=")).length % 3 == 0) {
        // String multiNums = group.substring(0, group.indexOf("="));
        // RegExp exp = RegExp(r"\d{3}");
        // Iterable<Match> matches = exp.allMatches(multiNums);
        // List<String?> xResults = matches.map((m) => m.group(0)).toList();
        // if (xResults.toSet().length != xResults.length) {
        //   return false;
        // }
        return true;
      }
    }

    if (group.contains("R") && 'R'.allMatches(group).length == 1) {
      if (group.contains("=")) {
        if (BigInt.tryParse(group.substring(0, group.indexOf("="))) != null &&
            group.substring(0, group.indexOf("=")).length % 3 == 0 &&
            "=".allMatches(group).length == 1) {
          print(56789);
          String multiNums = group.substring(0, group.indexOf("="));
          RegExp exp = RegExp(r"\d{3}");
          Iterable<Match> matches = exp.allMatches(multiNums);
          List<String?> xResults = matches.map((m) => m.group(0)).toList();

          // if (xResults.length != xResults.toSet().toList().length) {
          //   return false;
          // }
          List tempNums = [];
          for (String? x in xResults) {
            if (isAllSame(x!)) {
              return false;
            }
            tempNums.addAll(get3dR(x));
          }

          print(tempNums);
          print(tempNums.toSet().toList());
          print("$tempNums tempNums");
          // if (tempNums.length != tempNums.toSet().toList().length) {
          //   return false;
          // }
          print(1356);
          return true;
        }
      } else if (group.length == 4 && group.contains("R")) {
        if (BigInt.tryParse(group.substring(0, 3)) != null) {
          if (!isAllSame(group.substring(0, 3))) {
            return true;
          }
        }
      } else if (group.length > 4 && group.contains("R")) {
        if (BigInt.tryParse(group.substring(0, group.indexOf("R"))) != null) {
          if (!isAllSame(group.substring(0, 3))) {
            return true;
          }
        }
      }
    }

    return false;
  } catch (e) {
    return false;
  }
}

bool isAllSame(String num) {
  if (num[0] == num[1] && num[1] == num[2] && num[0] == num[2]) {
    return true;
  }
  return false;
}

List splitGroup(String groupPair) {
  List splited = [];

  if (BigInt.tryParse(groupPair) != null ||
      (groupPair[0] == "F" &&
          !groupPair.contains("=") &&
          !groupPair.contains("R"))) {
    if (groupPair.length > 2) {
      splited = [
        groupPair.substring(0, 2),
        groupPair.substring(2, groupPair.length)
      ];
    }
  } else {
    for (int x = groupPair.length - 1; x >= 0; x--) {
      if (BigInt.tryParse(groupPair[x]) == null) {
        splited = [
          groupPair.substring(0, x + 1),
          groupPair.substring(x + 1, groupPair.length)
        ];
        break;
      }
    }
  }
  return splited;
}

List splitGroup3D(String groupPair) {
  List splited = [];

  if (groupPair.contains("F")) {
    splited = [
      groupPair.substring(0, 3),
      groupPair.substring(3, groupPair.length)
    ];
    return splited;
  }

  if (BigInt.tryParse(groupPair) != null) {
    if (groupPair.length > 3) {
      splited = [
        groupPair.substring(0, 3),
        groupPair.substring(3, groupPair.length)
      ];
    }
  } else {
    for (int x = groupPair.length - 1; x >= 0; x--) {
      if (BigInt.tryParse(groupPair[x]) == null) {
        splited = [
          groupPair.substring(0, x + 1),
          groupPair.substring(x + 1, groupPair.length)
        ];
        break;
      }
    }
  }
  return splited;
}

List<String> checkGetNumsFromGroup(String group) {
  List<String> nums = getNumsFromGroup(group);
  print("qsc ${nums.length}");

  List<String> newRes = [];
  for (String x in nums) {
    if (x.length == 1) {
      x = "0$x";
    }
    newRes.add(x);
  }
  print("qsc ${newRes.length} ${nums.length}");
  return newRes;
}

List<String> getP(String vx) {
  List<String> tempP = [];
  for (int x = 0; x < 10; x++) {
    String v = x.toString() + vx;
    String w = vx + x.toString();
    tempP.addAll([v, w]);
  }
  // print("qsc ${tempP.toSet().toList().length}");
  return tempP.toSet().toList();
}

List<String> checkGetNumsFromGroup3D(String group) {
  List<String> nums = getNumsFromGroup3D(group);
  List<String> newRes = [];
  for (String x in nums) {
    if (x.length == 1) {
      x = "00$x";
    } else if (x.length == 2) {
      x = "0$x";
    }
    newRes.add(x);
  }
  return newRes;
}

List<String> getNumsFromGroup(String group) {
  print("lee gp $group");
  List<String> nums = [];

  if (BigInt.tryParse(group) != null) {
    nums.add(group);
    return nums;
  }

  if (group.contains("A")) {
    nums.addAll(
      [11, 22, 33, 44, 55, 66, 77, 88, 99, 00]
          .map((e) => e.toString())
          .toList(),
    );
    return nums;
  }

  if (group.contains("W")) {
    nums.addAll(
      [05, 16, 27, 38, 49, 50, 61, 72, 83, 94]
          .map((e) => e.toString())
          .toList(),
    );
    return nums;
  }

  if (group.contains("N")) {
    nums.addAll(
      [18, 70, 42, 69, 53, 81, 07, 24, 96, 35]
          .map((e) => e.toString())
          .toList(),
    );
    return nums;
  }

  if (group.contains("X")) {
    nums.addAll(
      [
        01,
        12,
        23,
        34,
        45,
        56,
        67,
        78,
        89,
        90,
        10,
        21,
        32,
        43,
        54,
        65,
        76,
        87,
        98,
        09
      ].map((e) => e.toString()).toList(),
    );
    return nums;
  }

  if (group.contains("P") &&
      "P".allMatches(group).length == 1 &&
      group.contains("=") &&
      "=".allMatches(group).length == 1 &&
      int.tryParse(group.substring(0, group.indexOf("P"))) != null) {
    List prefix = group.substring(0, group.indexOf("P")).split('');
    if (prefix.length == prefix.toSet().length) {
      List<String> tempshits = [];
      for (String x in prefix) {
        tempshits.addAll(getP(x));
      }

      print("PXPXPX ${tempshits.length} $tempshits");
      nums.addAll(tempshits);
      print("PPPPPPPPP ${nums.length} $nums");
      return nums;
    }
  }

  if (group.contains("P") && !group.contains("=")) {
    nums.addAll(getP(group[0]));
    // print("PPPPPPPPP  ${nums.length} $nums");
    return nums;
  }

  if (group.contains("R")) {
    String first = group.substring(0, 2);
    String second = first.split('').reversed.join('');

    nums.addAll([
      first,
      second,
    ]);
    return nums;
  }

  if (group.contains("B")) {
    String b = group[0];
    for (int x = 0; x < 100; x++) {
      String z;
      if (x.toString().length == 1) {
        z = "0${x.toString()}";
      } else {
        z = x.toString();
      }

      String zsum = (BigInt.parse(z[0]) + BigInt.parse(z[1])).toString();
      if (zsum[zsum.length - 1] == b) {
        nums.add(z);
      }
    }
    return nums;
  }

  if (group.contains("F") && group.length == 2) {
    return getFnums(group);
  }

  if (group.contains("F") && group.contains("=") && group.length > 2) {
    print("F lee pr  $group");
    if (group.contains("F=") && int.tryParse(group[0]) != null) {
      List<String> tempnum = [];

      for (String each in group.substring(0, group.indexOf("F")).split("")) {
        tempnum.addAll(getFnums("${each}F"));
      }

      nums.addAll(tempnum);

      return nums;
    } else if (group[0] == "F" &&
        int.tryParse(group.substring(1, group.indexOf("="))) != null) {
      List<String> tempnum = [];

      for (String each in group.substring(1, group.indexOf("=")).split("")) {
        tempnum.addAll(getFnums("F${each}"));
      }
      nums.addAll(tempnum);
      return nums;
    }
  }

  if (group.contains("F") && group.contains("R")) {
    return getFnums(group.substring(0, 2));
  }

  if (group.contains("K")) {
    bool canContainTwins = false;

    if (group.substring(group.length - 2, group.length) == "KK") {
      canContainTwins = true;
    }

    List kList;
    List<String> kResults = [];
    if (canContainTwins) {
      kList = group.substring(0, group.length - 2).split('');
    } else {
      kList = group.substring(0, group.length - 1).split('');
    }

    for (String v in kList) {
      for (String w in kList) {
        kResults.add("$v$w");
      }
    }

    if (canContainTwins) {
      kResults = kResults.toSet().toList();
    } else {
      kResults.removeWhere((element) => element[0] == element[1]);
      kResults = kResults.toSet().toList();
    }

    nums.addAll(kResults);

    return nums;
  }

  if (group.contains("J")) {
    try {
      final firstJ = group.substring(0, group.indexOf("J"));
      final secondJ = group.substring(group.indexOf("J") + 1, group.length - 1);
      List firstList = firstJ.split('');
      List secondList = secondJ.split('');

      List<String> jResults = [];
      for (String v in firstList) {
        for (String w in secondList) {
          jResults.add("$v$w");
          jResults.add("$w$v");
        }
      }
      nums.addAll(jResults);
    } catch (e) {
      return [];
    }

    return nums;
  }

  if (group.split('').last == "=") {
    String multiNums = group.substring(0, group.length - 1);
    RegExp exp = RegExp(r"\d{2}");
    Iterable<Match> matches = exp.allMatches(multiNums);
    List<String?> xResults = matches.map((m) => m.group(0)).toList();
    nums.addAll(xResults.cast<String>());
    return nums;
  }

  if (group == "SS") {
    List<String> res = [];
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 10; y++) {
        if (x.isEven && y.isEven) {
          res.add("$x$y");
        }
      }
    }
    nums.addAll(res.toSet().toList());
    return nums;
  }
  if (group == "MM") {
    List<String> res = [];
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 10; y++) {
        if (x.isOdd && y.isOdd) {
          res.add("$x$y");
        }
      }
    }
    nums.addAll(res.toSet().toList());
    return nums;
  }
  if (group == "SM") {
    List<String> res = [];
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 10; y++) {
        if (x.isEven && y.isOdd) {
          res.add("$x$y");
        }
      }
    }
    nums.addAll(res.toSet().toList());
    return nums;
  }
  if (group == "MS") {
    List<String> res = [];
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 10; y++) {
        if (x.isOdd && y.isEven) {
          res.add("$x$y");
        }
      }
    }
    nums.addAll(res.toSet().toList());
    return nums;
  }

  return nums;
}

List<String> getFnums(group) {
  List<String> nums = [];
  bool isFLast = true;
  if (group.indexOf("F") == 0) {
    isFLast = false;
  }
  String fnum = isFLast ? group[0] : group[1];

  for (int x = 0; x < 100; x++) {
    String v;
    if (x.toString().length == 1) {
      v = "0${x.toString()}";
    } else {
      v = x.toString();
    }
    if (isFLast) {
      if (v.split('').first == fnum) {
        nums.add(v);
      }
    } else {
      if (v.split('').last == fnum) {
        nums.add(v);
      }
    }
  }
  return nums;
}

List<String> getNumsFromGroup3D(String group) {
  List<String> nums = [];

  if (BigInt.tryParse(group) != null) {
    nums.add(group);
    return nums;
  }

  if (group.contains("A")) {
    nums.addAll(
      [111, 222, 333, 444, 555, 666, 777, 888, 999, 000]
          .map((e) => e.toString())
          .toList(),
    );
    return nums;
  }

  if (group.contains("F")) {
    List tmp = [];
    for (int i = 0; i < 10; i++) {
      tmp.add(group.replaceAll("F", i.toString()));
    }
    nums.addAll([...tmp]);
    return nums;
  }

  if (group.split('').last == "=" && !group.contains("R")) {
    String multiNums = group.substring(0, group.indexOf("="));
    RegExp exp = RegExp(r"\d{3}");
    Iterable<Match> matches = exp.allMatches(multiNums);
    List<String?> xResults = matches.map((m) => m.group(0)).toList();
    for (String? x in xResults) {
      nums.add(x!);
    }
    return nums;
  }

  if (group.contains("R") && 'R'.allMatches(group).length == 1) {
    if (group.contains("=")) {
      String multiNums = group.substring(0, group.indexOf("="));
      RegExp exp = RegExp(r"\d{3}");
      Iterable<Match> matches = exp.allMatches(multiNums);
      List<String?> xResults = matches.map((m) => m.group(0)).toList();
      if (xResults.length == xResults.toSet().toList().length) {
        for (String? x in xResults) {
          if (!isAllSame(x!)) {
            nums.addAll([...get3dR(x)]);
          }
        }
      }

      return nums;
    } else if (group.length == 4) {
      nums.addAll([...get3dR(group.substring(0, 3))]);
    }

    return nums;
  }

  return nums;
}

void generatePermutations(
    List<String> permutations, String prefix, String remaining) {
  if (remaining.isEmpty) {
    permutations.add(prefix);
  } else {
    for (int i = 0; i < remaining.length; i++) {
      generatePermutations(permutations, prefix + remaining[i],
          remaining.substring(0, i) + remaining.substring(i + 1));
    }
  }
}

List<String> get3dR(String input, {bool onlyCheck = true}) {
  List<String> permutations = [];
  generatePermutations(permutations, "", input);
  print(permutations.toSet().toList());
  print("$input Permu");
  List<String> result = permutations.toSet().toList();

  // if (onlycheck) {
  // int inputInt = int.parse(input);
  //   String suffix = (3 - inputInt.toString().length) == 0
  //       ? ""
  //       : "0" * (3 - inputInt.toString().length);
  //   if (input != "000") {
  //     result.add(suffix + (inputInt - 1).toString());
  //     print(suffix + (inputInt - 1).toString());
  //   }
  //   if (input != "999") {
  //     result.add(suffix + (inputInt + 1).toString());
  //     print(suffix + (inputInt + 1).toString());
  //   }
  // }

  // print("asdf${result}");

  return result;
}

int getTotalMoney(groupPair) {
  List<List<String>> nums = getNumAndPrice(groupPair);
  int tot = 0;
  for (List<String> x in nums) {
    tot += int.parse(x[1]);
  }
  return tot;
}

int getTotalMoney3D(groupPair) {
  List<List<String>> nums = getNumAndPrice3D(groupPair);
  print(2456);
  print("2456" + nums.toString());
  int tot = 0;
  for (List<String> x in nums) {
    tot += int.parse(x[1]);
  }
  return tot;
}

Map getDateandSection(datetime) {
  final DateTime dt = DateTime.fromMillisecondsSinceEpoch(datetime);
  return {
    "year": dt.year,
    "month": dt.month,
    "day": dt.day,
    "section": dt.hour >= 12 ? "PM" : "AM",
  };
}

Map getCurrentDateandSection() {
  return getDateandSection(DateTime.now().millisecondsSinceEpoch);
}

List<String> getAllPossibleNums() {
  List<String> res = [];
  for (int x = 0; x < 100; x++) {
    if (x.toString().length == 1) {
      res.add("0$x");
    } else {
      res.add(x.toString());
    }
  }
  return res;
}

List<String> getAll3DPossibleNums() {
  List<String> res = [];
  for (int x = 0; x < 1000; x++) {
    if (x.toString().length == 1) {
      res.add("00$x");
    } else if (x.toString().length == 2) {
      res.add("0$x");
    } else {
      res.add(x.toString());
    }
  }
  return res;
}

List<List<String>> getNumAndPrice(numpair) {
  List<List<String>> result = [];
  List splitted = splitGroup(numpair);
  String gp = splitted[0];
  String normalPrice = splitted[1];
  // int unit = Hive.box("KAM_misc").get("2dunit");

  print("BRUH numpair : $gp");

  if (gp.contains("R")) {
    if (gp.contains("=") && !gp.contains("F")) {
      if (BigInt.tryParse(gp.substring(0, gp.indexOf("="))) != null &&
          gp.substring(0, gp.indexOf("=")).length % 2 == 0) {
        final nl = gp.substring(0, gp.indexOf("="));
        RegExp exp = RegExp(r"\d{2}");
        Iterable<Match> matches = exp.allMatches(nl);
        List<String?> xResults = matches.map((m) => m.group(0)).toList();
        if (BigInt.tryParse(
                gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"))) !=
            null) {
          final xPrice = gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"));
          for (String? x in xResults) {
            result.add([x!, (int.parse(xPrice)).toString()]);
            result.add([
              x.split('').reversed.join(''),
              (int.parse(normalPrice)).toString()
            ]);
          }
        } else {
          for (String? x in xResults) {
            result.add([x!, (int.parse(normalPrice)).toString()]);
            result.add([
              x.split('').reversed.join(''),
              (int.parse(normalPrice)).toString()
            ]);
          }
        }
      }
    } else if (gp.contains("F") && gp.contains("R") && !gp.contains("=")) {
      String firstPrice = gp.substring(2, gp.indexOf("R"));
      String pat = gp.substring(0, 2);

      for (String n in getFnums(pat)) {
        result.add([n, int.parse(firstPrice).toString()]);
      }
      for (String m in getFnums(pat.split("").reversed.join(''))) {
        result.add([m, int.parse(normalPrice).toString()]);
      }
    } else if (gp.contains("F") && gp.contains("R") && gp.contains("=")) {
      print("COMPLEX FFF $gp");
      String firstPrice = gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"));

      if (gp.contains("F=") && int.tryParse(gp[0]) != null) {
        // List<List<String>> tempnum = [];

        for (String each in gp.substring(0, gp.indexOf("F")).split("")) {
          List daeList = getFnums("${each}F");
          List rList = getFnums("F${each}");

          for (String x in daeList) {
            result.add([x, int.parse(firstPrice).toString()]);
          }
          for (String y in rList) {
            result.add([y, int.parse(normalPrice).toString()]);
          }
        }

        // result.addAll(tempnum);
      } else if (gp[0] == "F" &&
          int.tryParse(gp.substring(1, gp.indexOf("="))) != null) {
        // List<String> tempnum = [];

        for (String each in gp.substring(1, gp.indexOf("=")).split("")) {
          // tempnum.addAll(getFnums("F${each}"));
          List daeList = getFnums("F${each}");
          List rList = getFnums("${each}F");

          for (String x in daeList) {
            result.add([x, int.parse(firstPrice).toString()]);
          }
          for (String y in rList) {
            result.add([y, int.parse(normalPrice).toString()]);
          }
        }
        // result.addAll(tempnum);
      }

      print("frog result $result");
    } else if (gp.length == 3) {
      final n = gp.substring(0, 2);
      result.add([n, (int.parse(normalPrice)).toString()]);
      result.add(
          [n.split('').reversed.join(''), (int.parse(normalPrice)).toString()]);
    } else if (gp.length > 3 &&
        BigInt.tryParse(gp.substring(0, gp.indexOf("R"))) != null) {
      final n = gp.substring(0, 2);
      result.add([n, (int.parse(gp.substring(2, gp.indexOf("R")))).toString()]);
      result.add(
          [n.split('').reversed.join(''), (int.parse(normalPrice)).toString()]);
    }
  } else {
    List norNums = checkGetNumsFromGroup(gp);
    for (String x in norNums) {
      result.add([x, (int.parse(normalPrice)).toString()]);
    }
    print("PRICEY $normalPrice ${norNums.length}");
  }

  return result;
}

List<List<String>> getNumAndPrice3D(numpair) {
  List<List<String>> result = [];
  List splitted = splitGroup3D(numpair);
  String gp = splitted[0];
  String normalPrice = splitted[1];
  // int unit = Hive.box("KAM_misc").get("3dunit");

  if (gp.contains("=") &&
      gp.contains("R") &&
      int.tryParse(gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"))) !=
          null) {
    if (gp.indexOf("=") == "3") {
      List threes = [];
      threes = get3dR(gp.substring(0, 3));
      result
          .add([threes[0], gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"))]);
      threes.removeAt(0);
      for (String x in threes) {
        result.add([x, (int.parse(normalPrice)).toString()]);
      }
    } else {
      String multiNums = gp.substring(0, gp.indexOf("="));
      RegExp exp = RegExp(r"\d{3}");
      Iterable<Match> matches = exp.allMatches(multiNums);
      List<String?> xResults = matches.map((m) => m.group(0)).toList();
      for (var x in xResults) {
        List threes = [];
        threes = get3dR(x!);
        result.add(
            [threes[0], gp.substring(gp.indexOf("=") + 1, gp.indexOf("R"))]);
        threes.removeAt(0);
        for (String x in threes) {
          result.add([x, normalPrice]);
        }
      }
    }
  } else if (gp.contains("=R")) {
    String multiNums = gp.substring(0, gp.indexOf("="));
    RegExp exp = RegExp(r"\d{3}");
    Iterable<Match> matches = exp.allMatches(multiNums);
    List<String?> xResults = matches.map((m) => m.group(0)).toList();
    for (var x in xResults) {
      List threes = [];
      threes = get3dR(x!);

      for (String x in threes) {
        result.add([x, normalPrice]);
      }
    }
  } else if (gp.contains("R") && gp.substring(0, gp.indexOf("R")).length > 3) {
    result.add([gp.substring(0, 3), gp.substring(3, gp.indexOf("R"))]);
    List ts = get3dR(gp.substring(0, 3));
    ts.removeAt(0);
    for (String x in ts) {
      result.add([x, normalPrice]);
    }
  } else {
    List norNums = checkGetNumsFromGroup3D(gp);
    for (String x in norNums) {
      result.add([x, normalPrice]);
    }
  }

  return result;
}

// suspect
Map splitMemberAndVNum(String memberVNum) {
  int? idx;
  String m;
  int vnum;

  for (int x = memberVNum.length - 1; x > 0; x--) {
    if (idx == null && BigInt.tryParse(memberVNum[x]) == null) {
      idx = x;
    }
  }
  idx ??= 0;

  m = memberVNum.substring(0, idx + 1);
  vnum = int.parse(memberVNum.substring(idx + 1, memberVNum.length));
  return {
    "member": m,
    "vnum": vnum,
  };
}

String dateFormatWithDash(DateTime dt) {
  return DateFormat("dd-MM-yyyy").format(dt);
}

String dateFormatWithDashNoyear(DateTime dt) {
  return DateFormat("dd-MM").format(dt);
}

String getDisplayNum(String numPair) {
  if (numPair.isEmpty) {
    return numPair;
  }
  List separated = splitGroup(numPair);
  String group = separated[0];
  String price = separated[1];

  print("poiu ${group.contains("=") && group.contains("P")}");
  String res;

  if (group.contains("=") && group.contains("F")) {
    print("F lee $group");
    if (group.contains("F=") && int.tryParse(group[0]) != null) {
      String temp = "";
      for (String each in group.substring(0, group.indexOf("F")).split("")) {
        // tempnum.addAll(getFnums("${each}F"));
        temp += "${each}F-";
      }
      if (temp.split("").last == "-") {
        temp = temp.substring(0, temp.length - 1);
      }

      String extra = '';
      if (numPair.contains("R")) {
        extra = " " +
            group.substring(group.indexOf("=") + 1, group.indexOf("R") + 1);
      }
      group = temp + "=" + extra;
    } else if (group[0] == "F" &&
        int.tryParse(group.substring(1, group.indexOf("="))) != null) {
      String temp = "";
      for (String each in group.substring(1, group.indexOf("=")).split("")) {
        // tempnum.addAll(getFnums("${each}F"));
        temp += "F${each}-";
      }
      if (temp.split("").last == "-") {
        temp = temp.substring(0, temp.length - 1);
      }
      String extra = '';
      if (numPair.contains("R")) {
        extra = " " +
            group.substring(group.indexOf("=") + 1, group.indexOf("R") + 1);
      }
      group = temp + "=" + extra;
    }
  } else if (group.contains("=") &&
      !group.contains("J") &&
      !group.contains("P")) {
    group = addDashToMultiple(group);
  } else if (group.contains("=") && group.contains("P")) {
    print("loki");
    List prefix = group.substring(0, group.indexOf("P")).split("");
    String temp = "";
    for (String p in prefix) {
      temp += "${p}P-";
    }
    if (temp.split("").last == "-") {
      List x = temp.split("");
      x.removeLast();
      temp = x.join("");
    }
    temp += "=";
    group = temp;
  } else if (group.contains("B")) {
    if (group[group.indexOf("B") - 1] != "9") {
      group =
          "${group[group.indexOf("B") - 1]}/1${group[group.indexOf("B") - 1]}B";
    }
  }
  if (group.contains("R")) {
    List sp = group.split("");
    sp.removeAt(group.length - 1);

    if (!group.contains("=") &&
        group.substring(0, group.indexOf("R")).length != 2) {
      sp.insert(2, " ");
    }

    res = "${sp.join("")} R$price";
  } else {
    res = "$group $price";
  }

  if (res.contains("=")) {
    List asdf = res.split("");
    asdf.insert(res.indexOf("="), " ");
    res = asdf.join("");
  }
  return res;
}

String getDisplayNum3D(String numPair) {
  List separated = splitGroup3D(numPair);
  String group = separated[0];
  String price = separated[1];

  String res;

  if (group.contains("=") && !group.contains("J")) {
    group = addDashToMultiple3D(group);
  }
  if (group.contains("R")) {
    List sp = group.split("");
    sp.removeAt(group.length - 1);

    if (!group.contains("=") &&
        group.substring(0, group.indexOf("R")).length != 3) {
      sp.insert(3, " ");
    }

    res = "${sp.join("")} R$price";
  } else if (group.contains("A")) {
    res = "AAA $price";
  } else {
    res = "$group $price";
  }

  if (res.contains("=")) {
    List asdf = res.split("");
    asdf.insert(res.indexOf("="), " ");
    res = asdf.join("");
  }

  return res;
}

String addDashToMultiple(String group) {
  String multiNums = group.substring(0, group.indexOf("="));
  String restString = group.substring(group.indexOf("="), group.length);
  RegExp exp = RegExp(r"\d{2}");
  Iterable<Match> matches = exp.allMatches(multiNums);
  List<String?> xResults = matches.map((m) => m.group(0)).toList();
  group = xResults.join("-");
  group += restString;
  return group;
}

String addDashToMultiple3D(String group) {
  String multiNums = group.substring(0, group.indexOf("="));
  String restString = group.substring(group.indexOf("="), group.length);
  RegExp exp = RegExp(r"\d{3}");
  Iterable<Match> matches = exp.allMatches(multiNums);
  List<String?> xResults = matches.map((m) => m.group(0)).toList();
  group = xResults.join("-");
  group += restString;
  return group;
}

String getNonDashGroup(String dashGroup) {
  String multiNums = dashGroup.substring(0, dashGroup.indexOf("="));

  String restString =
      dashGroup.substring(dashGroup.indexOf("="), dashGroup.length);
  multiNums = multiNums.split("-").join('');
  return multiNums + restString;
}

String getActualNumFromDisplay(String numPair) {
  List separated = splitGroup(numPair);
  String group = separated[0];
  String price = separated[1];

  if (group.contains("=") && !group.contains("J")) {
    group = getNonDashGroup(group);
  }

  if (group.contains("B")) {
    if (group[group.indexOf("B") - 1] != "9") {
      group = "${group[group.indexOf("B") - 1]}B";
    }
  }

  return "$group$price";
}

String getCopyTextNum(String groupPair) {
  // groupPair = getDisplayNum(groupPair).split(" ").join('');
  // if (BigInt.tryParse(groupPair) != null) {
  groupPair = getDisplayNum(groupPair);
  print("aefy xxx $groupPair");
  // }
  return groupPair;
}

String getCopyTextNum3D(String groupPair) {
  // if (BigInt.tryParse(groupPair) != null) {
  groupPair = getDisplayNum3D(groupPair);
  // }
  return groupPair;
}

String getCopyTextNumReverse(String groupPair) {
  groupPair = getActualNumFromDisplay(groupPair);
  groupPair = groupPair.replaceAll(RegExp(r"\s+"), "");
  print(groupPair);

  return groupPair;
}

String formatNums(number) {
  var formatter = NumberFormat('#,###,###');
  return formatter.format(number);
}

bool isItThisSection(year, month, day, section) {
  Map ds = getCurrentDateandSection();
  if (ds["year"] == year &&
      ds["month"] == month &&
      ds["day"] == day &&
      ds["section"] == section) {
    return true;
  }
  return false;
}

bool isItToday(year, month, day) {
  Map ds = getCurrentDateandSection();
  if (ds["year"] == year && ds["month"] == month && ds["day"] == day) {
    return true;
  }
  return false;
}

void checkvnum() {
  var vbox = Hive.box("KAM_vouncher");

  List vDatas = [
    vbox.get("vyear"),
    vbox.get("vmonth"),
    vbox.get("vday"),
    vbox.get("vsection"),
    vbox.get("vnum"),
  ];
  final Map secAndDate = getCurrentDateandSection();
  if (vDatas.any((element) => element == null)) {
    vbox.put('vyear', secAndDate["year"]);
    vbox.put('vmonth', secAndDate["month"]);
    vbox.put('vday', secAndDate["day"]);
    vbox.put('vsection', secAndDate["section"]);
    vbox.put('vnum', 1);
  } else {
    if (secAndDate["year"] != vDatas[0] ||
        secAndDate["month"] != vDatas[1] ||
        secAndDate["day"] != vDatas[2] ||
        secAndDate["section"] != vDatas[3]) {
      vbox.put('vyear', secAndDate["year"]);
      vbox.put('vmonth', secAndDate["month"]);
      vbox.put('vday', secAndDate["day"]);
      vbox.put('vsection', secAndDate["section"]);
      vbox.put('vnum', 1);
    }
  }
}

void checkvnum3D() {
  var vbox = Hive.box("KAM_vouncher_3D");

  List vDatas = [
    vbox.get("vyear"),
    vbox.get("vmonth"),
    vbox.get("vday"),
    vbox.get("vsection"),
    vbox.get("vnum"),
  ];
  final Map secAndDate = getCurrentDateandSection();
  if (vDatas.any((element) => element == null)) {
    vbox.put('vyear', secAndDate["year"]);
    vbox.put('vmonth', secAndDate["month"]);
    vbox.put('vday', secAndDate["day"]);
    vbox.put('vsection', secAndDate["section"]);
    vbox.put('vnum', 1);
  } else {
    if (secAndDate["year"] != vDatas[0] ||
        secAndDate["month"] != vDatas[1] ||
        secAndDate["day"] != vDatas[2] ||
        secAndDate["section"] != vDatas[3]) {
      vbox.put('vyear', secAndDate["year"]);
      vbox.put('vmonth', secAndDate["month"]);
      vbox.put('vday', secAndDate["day"]);
      vbox.put('vsection', secAndDate["section"]);
      vbox.put('vnum', 1);
    }
  }
}

void checkminmax() {
  var vbox = Hive.box("KAM_misc");
  if (vbox.get("min-amount") == null || vbox.get("max-amount") == null) {
    vbox.put("min-amount", 50);
    vbox.put("max-amount", 10000000);
  }
  if (vbox.get("3d-min-amount") == null || vbox.get("3d-max-amount") == null) {
    vbox.put("3d-min-amount", 50);
    vbox.put("3d-max-amount", 10000000);
  }
}

// Future<Uint8List> removeWhiteBackgroundFromImage(
//     Uint8List bytes) async {
//   Img.Image image = Img.decodeImage(bytes);
//   Img.Image transparentImage = await _colorTransparent(image, 255, 255, 255);
//   var newPng = Img.encodePng(transparentImage);
//   return newPng;
// }

// Future<Img.Image> _colorTransparent(
//     Img.Image src, int red, int green, int blue) async {
//   var pixels = src.getBytes();
//   for (int i = 0, len = pixels.length; i < len; i += 4) {
//     if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
//       pixels[i + 3] = 0;
//     }
//   }

//   return src;
// }

class PrintWidget extends StatelessWidget {
  PrintWidget({
    super.key,
    required this.vouncher,
    required this.owner,
    required this.member,
    required this.gps,
    required this.total,
    this.type = 2,
  });

  final Map vouncher;
  final String owner;
  final Map member;
  final List gps;
  final double total;
  final int type;

  final Box miscBix = Hive.box("KAM_misc");

  double getFontSize() {
    int sz = miscBix.get("print-size");
    if (sz == 0) {
      return 20;
    } else if (sz == 1) {
      return 26;
    } else {
      return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(gps.length < 5 ? 50 : 30);
    print(gps.length);
    return SingleChildScrollView(
      child: Container(
        width: 300,
        constraints:
            BoxConstraints(minWidth: 200, minHeight: 250 + (gps.length * 1)),
        color: Colors.white,
        padding: const EdgeInsets.only(top: 0, left: 0, right: 12, bottom: 32),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    "$owner-${member["name"]}${vouncher["vouncher_num"]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 16,
                // ),
                Container(
                  child: Text(
                    type == 2
                        ? "${dateFormatWithDashNoyear(DateTime(vouncher["year"], vouncher["month"], vouncher["day"]))}${vouncher["section"]}"
                        : "${dateFormatWithDashNoyear(DateTime(vouncher["year"], vouncher["month"], vouncher["day"]))}}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 32,
                // ),
                // SizedBox(
                //   width: 32,
                // ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black, height: 5, thickness: 2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${DateTime.now().year}-${DateTime.now().month}- ${DateTime.now().day}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getFontSize(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // SizedBox(
                //   width: 32,
                // ),
                FittedBox(
                  child: Text(
                    "${formatttttedTime(DateTime.now().hour, DateTime.now().minute)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black, height: 5, thickness: 2),
            const SizedBox(height: 16),
            for (Map x in gps)
              Row(
                children: [
                  Flexible(
                    child: Text(
                      type == 2
                          ? getDisplayNum(x["value"])
                          : getDisplayNum3D(x["value"]),
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getFontSize(),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black, height: 5, thickness: 2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getFontSize(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // SizedBox(
                //   width: 32,
                // ),
                FittedBox(
                  child: Text(
                    "${total.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black, height: 5, thickness: 2),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void setdefaults() {
  var vbox = Hive.box("KAM_misc");
  if (vbox.get("print-size") == null) {
    vbox.put("print-size", 0);
  }

  // if (vbox.get("owner") == null) {
  //   vbox.put("owner", "KAM");
  // }

  if (vbox.get("over-limit") == null) {
    vbox.put("over-limit", 0);
  }

  if (vbox.get("keyboard-type") == null) {
    vbox.put("keyboard-type", 0);
  }

  if (vbox.get("hots") == null) {
    vbox.put("hots", []);
  }
  if (vbox.get("3Dhots") == null) {
    vbox.put("3Dhots", []);
  }
  if (vbox.get("pasteType") == null) {
    vbox.put("pasteType", 1);
  }
  if (vbox.get("vType") == null) {
    vbox.put("vType", 1);
  }

  if (vbox.get("mainPageType") == null) {
    vbox.put("mainPageType", 1);
  }
  if (vbox.get("copyType") == null) {
    vbox.put("copyType", 1);
  }
}

void insertText(String myText, TextEditingController con) {
  final text = con.text;
  final textSelection = con.selection;
  final newText = text.replaceRange(
    textSelection.start,
    textSelection.end,
    myText,
  );
  final myTextLength = myText.length;
  con.text = newText;
  con.selection = textSelection.copyWith(
    baseOffset: textSelection.start + myTextLength,
    extentOffset: textSelection.start + myTextLength,
  );

  print("TXT : ${con.text}");
}

void backspace(String text, TextEditingController con) {
  final text = con.text;
  final textSelection = con.selection;
  final selectionLength =
      textSelection.end - textSelection.start; // There is a selection.
  if (selectionLength > 0) {
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      '',
    );
    con.text = newText;
    con.selection = textSelection.copyWith(
      baseOffset: textSelection.start,
      extentOffset: textSelection.start,
    );
    return;
  } // The cursor is at the beginning.
  if (textSelection.start == 0) {
    return;
  } // Delete the previous character
  final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
  final offset = isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
  final newStart = textSelection.start - offset;
  final newEnd = textSelection.start;
  final newText = text.replaceRange(
    newStart,
    newEnd,
    '',
  );
  con.text = newText;
  con.selection = textSelection.copyWith(
    baseOffset: newStart,
    extentOffset: newStart,
  );
}

bool isUtf16Surrogate(int value) {
  return value & 0xF800 == 0xD800;
}

List<Map> getLast10Days() {
  Map ds = getCurrentDateandSection();
  DateTime dt = DateTime(ds["year"], ds["month"], ds["day"]);
  List<DateTime> last10Dt = [];
  List<Map> kamdt = [];
  for (int i = 1; i <= 10; i++) {
    last10Dt.add(dt.subtract(Duration(days: i)));
  }
  for (DateTime d in last10Dt) {
    kamdt.add({
      "year": d.year,
      "month": d.month,
      "day": d.day,
    });
  }
  return kamdt;
}

void addLoggedApps(app) {
  Box loginBox = Hive.box("KAM_login");
  List apps = loginBox.get("loggedApps");
  apps.add(app);

  loginBox.put("loggedApps", apps);
}

String applyUnit(type, group) {
  int unit = 1;
  List splitted = [group];

  if (type == 2) {
    unit = Hive.box("KAM_misc").get("2dunit");
    splitted = splitGroup(group);
  } else if (type == 3) {
    unit = Hive.box("KAM_misc").get("3dunit");
    splitted = splitGroup3D(group);
  } else {
    return group;
  }
  if (splitted[0].toString().contains("=") &&
      splitted[0].toString().contains("R")) {
    if (splitted[0]
            .toString()
            .substring(splitted[0].toString().indexOf("=") + 1,
                (splitted[0].toString().indexOf("R")))
            .length >
        0) {
      String first = splitted[0].toString().substring(
          splitted[0].toString().indexOf("=") + 1,
          (splitted[0].toString().indexOf("R")));
      splitted[0] = splitted[0]
              .toString()
              .substring(0, (splitted[0].toString().indexOf("="))) +
          "=" +
          (int.parse(first) * unit).toString() +
          "R";
      splitted[1] = int.parse(splitted[1]) * unit;
    } else {
      splitted[1] = int.parse(splitted[1]) * unit;
    }
  } else if (splitted[0].toString().contains("R") &&
      splitted[0]
              .toString()
              .substring(0, splitted[0].toString().indexOf("R"))
              .length !=
          type) {
    String first = splitted[0]
        .toString()
        .substring(type, splitted[0].toString().indexOf("R"));
    splitted[0] = splitted[0].toString().substring(0, type) +
        (int.parse(first) * unit).toString() +
        "R";
    splitted[1] = int.parse(splitted[1]) * unit;
  } else {
    splitted[1] = int.parse(splitted[1]) * unit;
  }

  print("unitss $splitted");
  return splitted.join('');
}

Future<void> clearALLAppData() async {
  await Hive.box('KAM_login').clear();
  await Hive.box('KAM_vouncher').clear();
  await Hive.box('KAM_vouncher_3D').clear();
  await Hive.box('KAM_misc').clear();
}

bool hasOverlappingIntegers(String inputString) {
  // Remove non-integer characters from the string
  String cleanedString = inputString.replaceAll(RegExp(r'[^0-9]'), '');

  // If the cleaned string is empty or has only one character, no overlapping can occur
  if (cleanedString.isEmpty || cleanedString.length == 1) {
    return false;
  }

  // Convert the cleaned string to a list of integers
  List<int> integers =
      cleanedString.split('').map((e) => int.parse(e)).toList();

  // Sort the list of integers
  integers.sort();

  // Check for overlapping integers
  for (int i = 0; i < integers.length - 1; i++) {
    if (integers[i] == integers[i + 1]) {
      // Found overlapping integers
      return true;
    }
  }

  // No overlapping integers found
  return false;
}

String formatttttedTime(h, m) {
  String hh;
  String mm;
  String sec;

  if (h > 12) {
    hh = (h - 12).toString();
  } else {
    hh = h.toString();
  }

  if (h == 12 || h == 0) {
    hh = "12";
  }
  mm = m.toString();

  if (h >= 12) {
    sec = "PM";
  } else {
    sec = "AM";
  }

  return "${hh}:${mm} $sec";
}
