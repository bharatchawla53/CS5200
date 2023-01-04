import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

public class DeleteReservation {

  private Scanner scanner;

  public boolean delete(Connection connection) {
    scanner = new Scanner(System.in);

    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("Would you like to cancel a prepaid reservation? Enter Y or N: ");
      if (scanner.hasNext()) {
        String input = scanner.next();

        if (input != null && input.toUpperCase(Locale.ROOT).equals("Y")) {
          invalidInput = false;
          return deleteRecord(connection);
        }
      }
    }
    return false;
  }

  private boolean deleteRecord(Connection connection) {
    List<String> customerIds = fetchCustomerIds(connection);
    List<String> slotIds = fetchSlotIds(connection);
    String customerId = null;
    String slotId = null;

    boolean invalidCustomerId = true;
    while(invalidCustomerId) {
      System.out.println("Enter customer id: ");
      if (scanner.hasNext()) {
        customerId = scanner.next();

        if (customerIds.contains(customerId)) {
          invalidCustomerId = false;
        } else {
          System.out.println("Invalid customer id, please try again.");
        }
      }
    }

    boolean invalidSlotId = true;
    while(invalidSlotId) {
      System.out.println("Enter slot id: ");
      if (scanner.hasNext()) {
        slotId = scanner.next();

        if (slotIds.contains(slotId)) {
          invalidSlotId = false;
        } else {
          System.out.println("Invalid slot id, please try again.");
        }
      }
    }

    return callDeleteReservation(connection, customerId, slotId);
  }

  protected List<String> fetchCustomerIds(Connection connection) {
    List<String> result = new ArrayList<>();
    String sqlStatement = "select customer_id from Customer";

    try {
      PreparedStatement preparedStatement = connection.prepareStatement(sqlStatement);
      ResultSet resultSet = preparedStatement.executeQuery();

      while (resultSet.next()) {
        result.add(resultSet.getString(1));
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }

    return result;
  }

  protected List<String> fetchSlotIds(Connection connection) {
    List<String> result = new ArrayList<>();
    String sqlStatement = "select slot_id from Slot";

    try {
      PreparedStatement preparedStatement = connection.prepareStatement(sqlStatement);
      ResultSet resultSet = preparedStatement.executeQuery();

      while (resultSet.next()) {
        result.add(resultSet.getString(1));
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }

    return result;
  }

  private boolean callDeleteReservation(Connection connection, String customerId, String slotId) {
    String sql = "{CALL deletePrepaidReservation(?,?)}";

    try {
      CallableStatement cs = connection.prepareCall(sql);
      cs.setString(1, customerId);
      cs.setString(2, slotId);
      cs.executeQuery();
      return true;
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }
    return false;
  }
}
