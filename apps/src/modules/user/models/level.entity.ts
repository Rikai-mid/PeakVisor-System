import { ChallengeEntity } from 'src/modules/event/models/challenge.entity';
import {
    Column,
    Entity,
    PrimaryColumn,
    BaseEntity,
    ManyToOne,
    JoinColumn
} from 'typeorm';

@Entity('levels')
export class LevelEntity extends BaseEntity {
    @PrimaryColumn()
    level_id: number;

    @ManyToOne(
        () => ChallengeEntity,
        challenge => challenge.challenge_id
    )
    @JoinColumn({
        name: 'challenge_id',
        referencedColumnName: 'challenge_id'
    })
    challenge_id: ChallengeEntity;

    @Column({ length: 100 })
    level_name: string;

    @Column({ length: 100 })
    tempo_name: string;

    @Column()
    tone_id: number;

    @Column({ length: 50 })
    tone_name: string;

    @Column({ length: 20 })
    tone_short_name: string;

    @Column()
    point: number;

    @Column()
    score_category_id: number;

    @Column({ length: 10 })
    created_by: string;

    @Column()
    capture_video_url: string;

    @Column()
    metronome_video_url: string;

    @Column()
    accompaniment_video_url: string;

    @Column()
    score_pdf_file: string;

    @Column()
    amazon_score_url: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
