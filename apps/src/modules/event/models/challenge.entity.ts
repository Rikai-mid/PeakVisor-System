import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    OneToOne,
    JoinColumn
} from 'typeorm';
import { UserEntity } from '../../auth/models/user.entity';

@Entity('challenges')
export class ChallengeEntity extends BaseEntity {
    @PrimaryColumn()
    challenge_id: number;

    @Column({ length: 100 })
    challenge_name: string;

    @Column({ length: 300 })
    challenge_content: string;

    @Column()
    stage_id: number;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
