import { Module } from '@nestjs/common';
import { AuthService } from './service/auth.service';
import { AuthController } from './controller/auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserEntity } from './models/user.entity';

@Module({
    imports: [TypeOrmModule.forFeature([UserEntity])],
    providers: [AuthService],
    controllers: [AuthController]
})
export class AuthModule {}
