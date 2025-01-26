package lk.ijse.computerdoctorecom.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Product {
    int productId;
    String productName;
    String productDescription;
    String productImage;
    int productQty;
    double productPrice;
    int categoryId;
}
