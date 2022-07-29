import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserController } from './controller/user.controller';
import { LevelEntity } from './models/level.entity';
import { UserProgressHistoryEntity } from './models/user-progress-history.entity';
import { SkillScoreEntity } from './models/skill-score.entity';
import { EventService } from './service/event.service';
import { UserProgressEntity } from './models/user-progress.entity';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            UserProgressHistoryEntity,
            SkillScoreEntity,
            LevelEntity,
            SkillScoreEntity,
            UserProgressEntity,
        ]),
    ],
    providers: [EventService],
    controllers: [UserController],
})
export class UserModule {}
