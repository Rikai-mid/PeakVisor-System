import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    OneToOne,
    JoinColumn,
} from 'typeorm';
import { UserEntity } from '../../auth/models/user.entity';

@Entity('user_progress_history')
export class UserProgressHistoryEntity extends BaseEntity {
    @PrimaryColumn()
    event_id: number;

    @OneToOne(
        () => UserEntity,
        user => user.user_id,
    )
    @JoinColumn({
        name: 'user_id',
        referencedColumnName: 'user_id',
    })
    user_id: UserEntity;

    @Column()
    point: number;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
