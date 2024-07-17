import 'package:gsheets/gsheets.dart';
import 'package:mactur_mobile/Pages/model/User.dart';

class excel_api {
  static const _credentials = r''' {
    "type": "service_account",
    "project_id": "folha-de-ponto-mactur",
    "private_key_id": "b93aab66151687eca3af1aad7f8e90c5da5dd4f4",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDOWQO70fCck/wt\nJ7pDuDmG2wBENMxtxpeVBWy5Ieq9Dncc7heIDckRT3PYz/PjLf3Q4zwmF4D6or3V\nu3St5UNbVTvpEJR4LEr51HZR5oEFPy/eyiRTJ2zVWKlY1FY8mdSvSECWKwO59sSa\n6jKwL9HloIsO/mw6QlLbmPgmOYN3l550Gngn5UF3a4XFCPZJRvbLSSOA60pYbbXw\nPbbEz0nPPjNGOIFoFLw3wueps3+SRwKpyzaeqNH+EWXHJ45rvmPiIlQr/CzHyVSf\nSxJVR4Stfj6Lhha1dcHehO5DykiZbSm73LqbJUmT3CBYWUsQUIZ3j6UtdG4OExyZ\nXIJUUZbTAgMBAAECggEAKMbwdPJU4SxhXi8GoRFL1Pl8QP5KE7t2Aw3yYVdxgvDT\n2xS18739qP0RgJv/rzpMeTYekcx9QYpdh1onAaJXwDnEwBb1sBXYrywsQZ0SjA3j\nkNxTd1dIK5T8ykAT1p/zprvZf5N6hgpc6dw0LhsVGJK0SD9A9fZbV2gQScV91Gj4\nCe+P0gZs48Ztnd2oaB4eydUv2M/AzJ9v5iy+vmyq6SBWK4kI/O9f0cjzjhgNm87z\n2ELDaMbcSh6nNSQOqJcZP2ObkHZZYBTwSoGIbxnNJO9tzFiyZSUS69fk7UdK94Yf\nTFwnRP0H39Q8JiIx4Fm+n3LgpFqnatHnQS/MMbPSAQKBgQDwYf3mJB3Elq8bv4y5\nPTy45IqLme4UNcocpXUz0JogDjvclkPXXJwqm4SmXPMD1wa3XV1Y4SZGzEro3TUK\n/40cstWUmKg8DXG2Q9GWksJh8nfYjjWUOLtcRXIIPoASweC+0MK9wKrR1APLuR8r\njb8ZpviJ49Hsas/7Qw0WC+OnAQKBgQDbwPT7dYhLhCRXHli2TRUJTYM9bfwNi+6k\noE0wIKzD9Xwx9o8IX2TJfOrVGGrHweG3f3R+nJfFoCJ02mK2uXc8bAa8NrjaZxQH\nSmE2Ao9Um4FffZxwbGlFxmccFFkM44aCyYI+xeAch0AgZAnVIvGXVFOAloWXkc1C\nXZ94lnfx0wKBgBxUsEPrhcahq8mtbbx3RyzTYrDJV5HyNPvjVEjjEQcuJkf9Pcmo\nFI/A/IVO9yVAtn3t9w5+mrBFa56+U34UWGFFgn6c71cEjp5Yp98DNP2uQgm32QC7\nHvnlBWeLVjTfvMlAeXM7veY1Aq2EB/RuJFO1ph06SIeAnzqR0H0EsbQBAoGASOno\nHzsrIutQZ3uRMcO3tCN85TgGBrSkVQk/MzXUPRzJvYYyhTOprFT/Uf9NBsSk0Q7A\nJ3ZrwU3VwPHpCPnWvzyUq4R4pzbGZXjfcl09E3SZY4a5DnBaKaWf9qglt+oSanjT\n92IOb0jNFTI8NPToNi7rmeHXp6ff9CI+VHOQjrMCgYEAjFk+mIHwzHlA/M/O9fBV\nBfQngzDW8/6aUfq/qJaDtlxtvYtuhoeEaBxf9uJ6QQ1kfUmLNBG6zF37ZZGDvHHy\nprj4GNNsE+yGwTDbRyc+zQm9ULJA4r2LJKoOewzfzs7L2z83hDZ1NmpVHJohsNjX\nYsEHMcKHgDDKI6A+QKptMo4=\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@folha-de-ponto-mactur.iam.gserviceaccount.com",
    "client_id": "109393396975455244153",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40folha-de-ponto-mactur.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }''';

  static const spreadsheetId = '1lW3l_8loAREg7MKX3As6tbs7ECMVu5i2CeNT_8Ne8ws';
  static final gsheets = GSheets(_credentials);
  static Worksheet? usersheet;
  static Future init() async {
    final spreadsheet = await gsheets.spreadsheet(spreadsheetId);
    usersheet = await _getWorkSheet(spreadsheet, title: 'Motoristas');

    final firstrow = userfields.getfields();
    usersheet!.values.insertRow(1, firstrow);
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  // ignore: non_constant_identifier_names
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (usersheet == null) return;
    usersheet!.values.map.appendRows(rowList);
  }
}
