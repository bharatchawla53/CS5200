import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

public class UpdateSlot {

  private Scanner scanner;
  private String customerId;
  private String slotId;

  public UpdateSlot() {
    this.scanner = new Scanner(System.in);
  }

  public void prompts(Connection connection) {
    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("Would you like to exit the garage? " +
              "Enter Y or N: ");
      if (scanner.hasNext()) {
        String input = scanner.next();
        if (input.toUpperCase(Locale.ROOT).equals("Y")) {
          invalidInput = false;
          updateSlots(connection);
        } else if (input.toUpperCase(Locale.ROOT).equals("N")) {
          invalidInput = false;
          return;
        } else {
          System.out.println("Invalid input, please try again");
        }
      }
    }
  }

  private void updateSlots(Connection connection) {
    getCustomerIdAndSlotId(connection);

    if (customerId != null && slotId != null) {
      String sql = "{? = call updateSlot(?,?)}";

      try {
        CallableStatement cs = connection.prepareCall(sql);
        cs.setString(2, customerId);
        cs.setString(3, slotId);
        ResultSet resultSet = cs.executeQuery();
        while (resultSet.next()) {
          if (resultSet.getInt(1) == 1) {
            System.out.println("Exiting the garage");
          }
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
