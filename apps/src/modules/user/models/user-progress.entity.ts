import { EventEntity } from 'src/modules/event/models/event.entity';
import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    OneToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
} from 'typeorm';
import { UserEntity } from '../../auth/models/user.entity';
import { LevelEntity } from './level.entity';

@Entity('user_progress')
export class UserProgressEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToOne(
        () => UserEntity,
        user => user.user_id,
    )
    @JoinColumn({
        name: 'user_id',
        referencedColumnName: 'user_id',
    })
    user_id: UserEntity;

    @OneToOne(
        () => LevelEntity,
        level => level.level_id,
    )
    @JoinColumn({
        name: 'level_id',
        referencedColumnName: 'level_id',
    })
    level_id: LevelEntity;

    @OneToOne(
        () => EventEntity,
        event => event.event_id,
    )
    @JoinColumn({
        name: 'event_id',
        referencedColumnName: 'event_id',
    })
    event_id: EventEntity;

    @Column()
    challenge_status: number;

    @Column()
    homework_status: number;

    @Column()
    total_achievement: number;

    @Column({ default: true })
    inprocess_flag: boolean;

    @Column({ default: true })
    unread_flag: boolean;

    @Column()
    first_achievement_time: Date;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
