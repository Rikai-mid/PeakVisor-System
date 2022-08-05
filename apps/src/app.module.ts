import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
// import { EventModule } from './modules/event/event.module';
// import { UserModule } from './modules/user/user.module';

@Module({
    imports: [
        ConfigModule.forRoot({ isGlobal: true }),
        TypeOrmModule.forRoot({
            type: 'postgres',
            host: process.env.POSTGRES_HOST,
            port: parseInt(process.env.POSTGRES_HOST),
            username: process.env.POSTGRES_USER,
            password: process.env.POSTGRES_PASSWORD,
            database: process.env.POSTGRES_DATABASE,
            entities: ['/apps/src/modules/**/models/*.entity.{ts,js}'],
            migrations: [__dirname + '/../database/migrations/*{.ts,.js}'],
            autoLoadEntities: true,
            synchronize: true
        }),
        AuthModule,
        // EventModule,
        // UserModule
    ],
    controllers: [AppController],
    providers: [AppService]
})
export class AppModule {}
