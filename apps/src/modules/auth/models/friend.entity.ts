import {
    Column,
    Entity,
    PrimaryColumn,
    PrimaryGeneratedColumn,
    BaseEntity,
    OneToOne,
    JoinColumn
} from 'typeorm';
import { UserEntity } from './user.entity';

@Entity('friends')
export class FriendEntity extends BaseEntity {
    @PrimaryColumn()
    friend_user_id: string;

    @OneToOne(
        () => UserEntity,
        user => user.user_id
    )
    @JoinColumn({
        name: 'user_id',
        referencedColumnName: 'user_id'
    })
    user_id: UserEntity;

    @Column()
    status?: number;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
