package lk.ijse.computerdoctorecom;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor

public class userDTO {
    int id;
    String name;
    String email;
    String password;
}
