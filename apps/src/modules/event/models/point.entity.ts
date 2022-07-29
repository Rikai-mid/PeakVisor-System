import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    OneToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    ManyToMany,
} from 'typeorm';
import { UserEntity } from '../../auth/models/user.entity';
import { EventEntity } from './event.entity';

@Entity('events')
export class PointEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToMany(
        () => EventEntity,
        event => event.event_id,
    )
    @JoinColumn({
        name: 'event_id',
        referencedColumnName: 'event_id',
    })
    event_id: EventEntity;

    @ManyToMany(
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
