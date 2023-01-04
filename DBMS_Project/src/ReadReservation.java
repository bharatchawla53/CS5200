import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class ReadReservation {

  private Scanner scanner;
  private String customerId;
  private String slotId;

  public void prompts(Connection connection) {
    scanner = new Scanner(System.in);

    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("1. Would you like to know the details of your reservation? ");
      System.out.println("2. Would you like to get the receipt of your recent reservation? ");
      System.out.println("Enter an option: ");
      if (scanner.hasNext()) {
        String input = scanner.next();

        if (input != null && input.equals("1")) {
          getCustomerIdAndSlotId(connection);
          invalidInput = false;
          readReservationDetails(connection);
        } else if (input != null && input.equals("2")) {
          getCustomerIdAndSlotId(connection);
          invalidInput = false;
          readReservationReceipt(connection);
        } else {
          System.out.println("Invalid input, please try again");
        }
      }
    }
  }

  private void readReservationDetails(Connection connection) {
    if (customerId != null && slotId != null) {
      String sql = "{CALL readReservationDetails(?,?)}";

      try {
        CallableStatement cs = connection.prepareCall(sql);
        cs.setString(1, customerId);
        cs.setString(2, slotId);
        ResultSet resultSet = cs.executeQuery();

        String colsNames = String.format("%-20s %-25s %-25s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s",
                "Reservation_id",
                "Reservation_timestamp",
                "Reservation_date",
                "Customer_id",
                "Slot_number",
                "Floor_number",
                "Block_id",
                "Block_code",
                "Garage_name",
                "Garage_Street",
                "Garage_city",
                "zipcode");
        System.out.println(colsNames);

        while (resultSet.next()) {
          String out = String.format("%-20d %-30s %-25s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s",
                  resultSet.getInt(1),
                  resultSet.getTimestamp(2),
                  resultSet.getString(3),
                  resultSet.getString(4),
                  resultSet.getString(5),
                  resultSet.getString(6),
                  resultSet.getString(7),
                  resultSet.getString(8),
                  resultSet.getString(9),
                  resultSet.getString(10),
                  resultSet.getString(11),
                  resultSet.getString(12));

          System.out.println(out);
        }

      } catch (SQLException e) {
        System.out.println(e.getLocalizedMessage());
      }
    }
  }


  private void readReservationReceipt(Connection connection) {
    if (customerId != null && slotId != null) {
      String sql = "{CALL readReservationReceipt(?,?)}";

      try {
        CallableStatement cs = connection.prepareCall(sql);
        cs.setString(1, customerId);
        cs.setString(2, slotId);
        ResultSet resultSet = cs.executeQuery();

        String colsNames = String.format("%-20s %-25s %-25s %-20s %-20s %-20s %-10s %-10s",
                "Reservation_slip_id",
                "Entry_time",
                "Exit_time",
                "Penalty",
                "Cost",
                "Total_cost",
                "Is_paid",
                "Reservation_id");
        System.out.println(colsNames);
        while (resultSet.next()) {
          String out = String.format("%-20d %-25s %-25s %-20s %-20s %-20s %-15d %-15d",
                  resultSet.getInt(1),
                  resultSet.getTimestamp(2),
                  resultSet.getTimestamp(3),
                  resultSet.getString(4),
                  resultSet.getString(5),
                  resultSet.getString(6),
                  resultSet.getInt(7),
                  resultSet.getInt(8));

          System.out.println(out);
        }

      } catch (SQLException e) {
        System.out.println(e.getLocalizedMessage());
      }
    }
  }

  private void getCustomerIdAndSlotId(Connection connection) {
    // reusing this class to fetch customer and slot ids
    DeleteReservation reservation = new DeleteReservation();
    List<String> customerIds = reservation.fetchCustomerIds(connection);
    List<String> slotIds = reservation.fetchSlotIds(connection);

    customerId = null;
    slotId = null;

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
  }
}
