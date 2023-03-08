package com.ssafy.snapstory.domain.quizTaleList;

import com.ssafy.snapstory.domain.Base;
import com.ssafy.snapstory.domain.quizTale.QuizTale;
import com.ssafy.snapstory.domain.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class QuizTaleList extends Base {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int quizTaleListId;

    @ManyToOne
    @JoinColumn(name="quizTaleId")
    private QuizTale quizTale;

    @ManyToOne
    @JoinColumn(name="userId")
    private User user;
}
