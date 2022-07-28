import { Column, Entity, PrimaryColumn, BaseEntity } from 'typeorm';

@Entity('skill_scores')
export class SkillScoreEntity extends BaseEntity {
    @PrimaryColumn()
    score_category_id: number;

    @Column({ length: 100 })
    score_category_name: string;

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
