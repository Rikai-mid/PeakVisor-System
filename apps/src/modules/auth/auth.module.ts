import {HttpModule, Module} from '@nestjs/common';
import { AuthService } from './service/auth.service';
import { AuthController } from './controller/auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserEntity } from './models/user.entity';
import { LoginManagementEntity } from './models/loginManagement.entity';
import { FriendEntity } from './models/friend.entity';
import { PrefectureEntity } from './models/prefecture.entity';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            UserEntity,
            LoginManagementEntity,
            FriendEntity,
            PrefectureEntity,
        ]),
        HttpModule,
    ],
    providers: [AuthService],
    controllers: [AuthController],
})
export class AuthModule {}
