import { UserEntity } from 'src/modules/auth/models/user.entity';
import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    PrimaryGeneratedColumn,
    ManyToMany,
    JoinColumn
} from 'typeorm';

@Entity('skill_scores')
export class SkillScoreEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToMany(
        () => UserEntity,
        user => user.user_id
    )
    @JoinColumn({
        name: 'user_id',
        referencedColumnName: 'user_id'
    })
    user_id: UserEntity;

    @ManyToMany(
        () => SkillScoreEntity,
        skillScore => skillScore.score_category_id
    )
    @JoinColumn({
        name: 'score_category_id',
        referencedColumnName: 'score_category_id'
    })
    score_category_id: SkillScoreEntity;

    @Column()
    achievement_level: number;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
